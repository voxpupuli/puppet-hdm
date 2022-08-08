# class hdm::rvm
class hdm::rvm {
  group { $hdm::group:
    ensure => present,
  }

  user { $hdm::user:
    ensure => present,
    shell  => '/sbin/nologin',
    home   => $hdm::hdm_path,
    gid    => $hdm::group,
  }

  file { $hdm::hdm_path:
    ensure => directory,
    owner  => $hdm::user,
    group  => $hdm::group,
  }

  include gnupg

  include rvm

  rvm::system_user { 'hdm':
    create => false,
  }

  rvm_system_ruby { "ruby-${hdm::ruby_version}":
    ensure      => present,
    default_use => false,
  }

  rvm_gem { 'bundler':
    ensure       => present,
    ruby_version => "ruby-${hdm::ruby_version}",
    require      => Rvm_system_ruby["ruby-${hdm::ruby_version}"],
  }

  # Fix for old g++ and sqlite3
  case $facts['os']['family'] {
    'RedHat': {
      if versioncmp($facts['os']['release']['major'], '8') < 0 {
        package { 'centos-release-scl':
          ensure => present,
        }

        package { 'devtoolset-7':
          ensure => present,
        }
        $exec_prefix = 'scl enable devtoolset-7 '
        exec { 'update sqlite':
          command => 'yum install -y https://kojipkgs.fedoraproject.org//packages/sqlite/3.8.11/1.fc21/x86_64/sqlite-devel-3.8.11-1.fc21.x86_64.rpm https://kojipkgs.fedoraproject.org//packages/sqlite/3.8.11/1.fc21/x86_64/sqlite-3.8.11-1.fc21.x86_64.rpm',
          path    => $facts['path'],
          unless  => 'rpm -q sqlite | grep 3.8',
        }
      } else {
        $exec_prefix = ''
      }
    }
    default: {
      $exec_prefix = ''
    }
  }

  vcsrepo { $hdm::hdm_path:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/betadots/hdm.git',
    revision => $hdm::version,
  }

  exec { 'bundle config path':
    command  => "source $(rvm ${hdm::ruby_version} do rvm env --path) && rvm ${hdm::ruby_version} do bundle config set --local path 'vendor/bundle'",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    unless   => 'grep vendor/bundle .bundle/config',
    provider => 'shell',
  }

  exec { 'bundle config development':
    command  => "source $(rvm ${hdm::ruby_version} do rvm env --path) && rvm ${hdm::ruby_version} do bundle config set --local with 'development'",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    unless   => 'grep development .bundle/config',
    provider => 'shell',
  }

  exec { 'bundle install':
    command  => "${exec_prefix} 'source $(rvm ${hdm::ruby_version} do rvm env --path) && rvm ${hdm::ruby_version} do bundle install --jobs $(nproc) && touch .bundle_install_finished'",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    creates  => "${hdm::hdm_path}/.bundle_install_finished",
    provider => 'shell',
  }

  file { "${hdm::hdm_path}/config/hdm.yml":
    ensure  => file,
    content => epp('hdm/hdm.yml.epp'),
  }

  exec { 'bundle db:setup':
    command  => "source $(rvm ${hdm::ruby_version} do rvm env --path) && rvm ${hdm::ruby_version} do bundle exec rails db:setup && touch .bundle_db_setup_finished",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    creates  => "${hdm::hdm_path}/.bundle_db_setup_finished",
    provider => 'shell',
  }

  exec { 'bundle rails credentials':
    command  => "source $(rvm ${hdm::ruby_version} do rvm env --path) && rvm ${hdm::ruby_version} do echo 'secret' | EDITOR='vim' bundle exec rails credentials:edit",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    creates  => "${hdm::hdm_path}/config/credentials.yml.enc",
    provider => 'shell',
  }

  systemd::unit_file { 'hdm.service':
    content => epp('hdm/hdm.service.epp'),
    enable  => true,
    active  => true,
  }
}

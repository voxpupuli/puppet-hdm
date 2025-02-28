# @summary Manage HDM using RVM
#
# This class installs the required Ruby version using RVM
# and runs HDM as systemd service
#
# @api private
class hdm::rvm {
  assert_private()

  # All exec rsources need the rvm environment
  Exec {
    environment => [
      "GEM_HOME=/usr/local/rvm/gems/ruby-${hdm::ruby_version}",
      "GEM_PATH=/usr/local/rvm/gems/ruby-${hdm::ruby_version}:/usr/local/rvm/gems/ruby-${hdm::ruby_version}@global",
      "MY_RUBY_HOME=>/usr/local/rvm/rubies/ruby-${hdm::ruby_version}",
      "IRBRC=/usr/local/rvm/rubies/ruby-${hdm::ruby_version}/.irbrc",
      "RUBY_VERSION=ruby-${hdm::ruby_version}",
    ],
  }

  # CentOS needs CRB repo (libyaml-devel)
  if $facts['os']['name'] == 'CentOS' {
    yumrepo { 'crb':
      ensure          => 'present',
      descr           => 'CentOS Stream $releasever - CRB',
      enabled         => '1',
      gpgcheck        => '1',
      gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial',
      metadata_expire => '6h',
      metalink        => 'https://mirrors.centos.org/metalink?repo=centos-crb-$stream&arch=$basearch&protocol=https,http',
      repo_gpgcheck   => '0',
    }
  }


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

  vcsrepo { $hdm::hdm_path:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/betadots/hdm.git',
    revision => $hdm::version,
  }

  exec { 'bundle config path':
    command  => "rvm ${hdm::ruby_version} do bundle config set --local path 'vendor/bundle'",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    unless   => 'grep vendor/bundle .bundle/config',
    provider => 'shell',
  }

  exec { 'bundle config development':
    command  => "rvm ${hdm::ruby_version} do bundle config set --local with 'development'",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    unless   => 'grep development .bundle/config',
    provider => 'shell',
  }

  exec { 'bundle install':
    command  => "rvm ${hdm::ruby_version} do bundle install --jobs $(nproc) && touch .bundle_install_finished",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    creates  => "${hdm::hdm_path}/.bundle_install_finished",
    provider => 'shell',
  }

  file { "${hdm::hdm_path}/config/hdm.yml":
    ensure  => file,
    content => epp('hdm/hdm.yml.epp'),
    notify  => Service['hdm.service'],
  }

  exec { 'bundle db:setup':
    command  => "rvm ${hdm::ruby_version} do bundle exec rails db:setup && touch .bundle_db_setup_finished",
    cwd      => $hdm::hdm_path,
    path     => "/usr/local/rvm/bin:${facts['path']}",
    creates  => "${hdm::hdm_path}/.bundle_db_setup_finished",
    provider => 'shell',
  }

  exec { 'bundle rails credentials':
    command  => "rvm ${hdm::ruby_version} do echo 'secret' | EDITOR='vim' bundle exec rails credentials:edit",
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

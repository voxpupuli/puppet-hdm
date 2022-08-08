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

  vcsrepo { $hdm::hdm_path:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/betadots/hdm.git',
    revision => $hdm::version,
  }

  exec { 'bundle config path':
    command => 'bundle config set --local path \'vendor/bundle\'',
    cwd     => $hdm::hdm_path,
    path    => $facts['path'],
    unless  => 'grep vendor/bundle .bundle/config',
  }

  exec { 'bundle config development':
    command => 'bundle config set --local with \'development\'',
    cwd     => $hdm::hdm_path,
    path    => $facts['path'],
    unless  => 'grep development .bundle/config',
  }

  exec { 'bundle install':
    command => 'bundle install --jobs $(nproc) && touch .bundle_install_finished',
    cwd     => $hdm::hdm_path,
    path    => $facts['path'],
    creates => "${hdm::hdm_path}/.bundle_install_finished",
  }

  file { "${hdm::hdm_path}/config/hdm.yml":
    ensure  => file,
    content => epp('hdm/hdm.yml.epp'),
  }

  exec { 'bundle db:setup':
    command => 'bundle exec rails db:setup && touch .bundle_db_setup_finished',
    cwd     => $hdm::hdm_path,
    path    => $facts['path'],
    creates => "${hdm::hdm_path}/.bundle_db_setup_finished",
  }

  exec { 'bundle rails credentials':
    command => 'echo "secret" | EDITOR="vim" bundle exec rails credentials:edit',
    cwd     => $hdm::hdm_path,
    path    => $facts['path'],
    creates => "${hdm::hdm_path}/config/credentials.yml.enc",
  }

  systemd::unit_file { 'hdm.service':
    content => epp('hdm/hdm.service.epp'),
    enable  => true,
    active  => true,
  }
}

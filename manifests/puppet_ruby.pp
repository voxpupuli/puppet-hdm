# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @api private
#
# @example
#   include hdm::puppet_ruby
class hdm::puppet_ruby {
  package { 'bundler':
    ensure   => present,
    provider => 'puppet_gem',
  }
  group { $hdm::group:
    ensure => present,
  }
  user { $hdm::user:
    ensure => present,
    gid    => $hdm::group,
    shell  => '/sbin/nologin',
  }
  vcsrepo { $hdm::hdm_path:
    ensure   => present,
    provider => 'git',
    source   => $hdm::git_url,
    revision => $hdm::version,
    user     => $hdm::user,
    group    => $hdm::group,
  }
  exec { 'bundle install':
    command => 'bundle install --path vendor --jobs $(npoc) && touch .bundle_install_finished',
    path    => "${facts['path']}:/opt/puppetlabs/puppet/bin",
    cwd     => $hdm::hdm_path,
    creates => "${hdm::hdm_path}/.bundle_install_finished",
  }
  file { "${hdm::hdm_path}/config/hdm.yml":
    ensure  => file,
    content => epp('hdm/hdm.yml.epp'),
  }
  exec { 'bundle db setup':
    command => 'bundle exec rails db:setup && touch .bundle_db_setup_finished',
    path    => "${facts['path']}:/opt/puppetlabs/puppet/bin",
    cwd     => $hdm::hdm_path,
    creates => "${hdm::hdm_path}/.bundle_db_setup_finished",
  }
  exec { 'bundle rais credentials':
    command => 'echo "secret" | EDITOR="vim" bundle exec rails credentials:edit',
    path    => "${facts['path']}:/opt/puppetlabs/puppet/bin",
    cwd     => $hdm::hdm_path,
    creates => "${hdm::hdm_path}/config/credentials.yml.enc",
  }
  systemd::unit_file { 'hdm.service':
    content => epp('hdm/hdm.service.epp'),
    enable  => true,
    active  => true,
  }
}

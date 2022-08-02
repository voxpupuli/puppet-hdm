# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include hdm::puppet_ruby
class hdm::puppet_ruby {
  package { 'bundler':
    ensure   => present,
    provider => 'puppet_gem',
  }
  vcsrepo { $hdm::hdm_path:
    ensure   => present,
    provider => 'git',
    source   => $hdm::git_url,
    revision => $hdm::version,
  }
  exec { 'bundle install':
    command => 'bundle install --path vendor',
    path    => "${facts['path']}:/opt/puppetlabs/puppet/bin",
    cwd     => $hdm::hdm_path,
    creates => "${hdm::hdm_path}/vendor",
  }
  file { "${hdm::hdm_path}/config/hdm.yml":
    ensure  => file,
    content => epp('hdm/hdm.yml.epp'),
  }
  exec { 'bundle db setup':
    command => 'bundle exec rails db:setup',
    path    => "${facts['path']}:/opt/puppetlabs/puppet/bin",
    cwd     => $hdm::hdm_path,
    creates => "${hdm::hdm_path}/db/development.sqlite3",
  }
  exec { 'bundle rais credentials':
    command => 'echo "secret" | EDITOR="vim" bundle exec rails credentials:edit',
    path    => "${facts['path']}:/opt/puppetlabs/puppet/bin",
    cwd     => $hdm::hdm_path,
    creates => "${hdm::hdm_path}/config/credentials.yml.enc",
  }
  file { '/etc/systemd/system/hdm.service':
    ensure => file,
    source => "${hdm::hdm_path}/config/hdm.service",
    notify => Exec['hdm daemon reload'],
  }
  exec { 'hdm daemon reload':
    command     => 'systemctl daemon reload',
    refreshonly => true,
  }
  service { 'hdm':
    ensure => running,
    enable => true,
  }
}

# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include hdm::docker
class hdm::docker {
  $directories = [
    '/etc/hdm',
    '/etc/hdm/certs',
    '/etc/hdm/db',
  ]
  file { $directories:
    ensure => directory,
  }
  file { '/etc/hdm/hdm.yml':
    ensure  => file,
    content => epp('modules/hdm/hdm.yml.epp'),
  }
  file { '/etc/hdm/database.yml':
    ensure  => file,
    content => epp('modules/hdm/database.yml'),
  }
  file { '/etc/hdm/db/development.sqlite3':
    ensure => file,
  }

  docker::image { 'ghcr.io/betadots/hdm':
    image_tag => $hdm::image_tag,
  }

  docker::run { 'hdm':
    image    => "ghcr.io/betadots/hdm:${hdm::image_tag}",
    env      => [
      'TZ=Europe/Berlin',
      "RAILS_DEVELOPMENT_HOSTS=${facts['fqdn']}",
    ],
    volumes  => [
      '/etc/hdm/:/etc/hdm',
      '/etc/puppetlabs/code:/etc/puppetlabs/code:ro',
      '/etc/hdm/hdm.yml:/hdm/config/hdm.yml:ro',
      '/etc/hdm/database.yml:/hdm/config/database.yml:ro',
    ],
    hostname => $facts['fqdn'],
    ports    => [$hdm::port],
    net      => 'host',
  }
}

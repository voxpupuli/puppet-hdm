# @summary Manage HDM using Docker
#
# This class installs docker and runs the HDM container.
#
# @api private
#
class hdm::docker {
  assert_private()

  if $hdm::manage_docker {
    include docker
  }

  group { $hdm::group:
    ensure => present,
  }

  $shell = $facts['os']['family'] ? {
    'Debian'         => '/usr/sbin/nologin',
    'RedHat', 'Suse' => '/sbin/nologin',
  }

  user { $hdm::user:
    ensure => present,
    gid    => $hdm::group,
    shell  => $shell,
  }

  $directories = [
    $hdm::hdm_path,
    "${hdm::hdm_path}/certs",
    "${hdm::hdm_path}/db",
  ]

  file { $directories:
    ensure => directory,
  }

  file { "${hdm::hdm_path}/hdm.yml":
    ensure  => file,
    content => epp('hdm/hdm.yml.epp'),
    notify  => Service['docker-hdm'],
  }

  file { "${hdm::hdm_path}/database.yml":
    ensure  => file,
    content => epp('hdm/database.yml'),
  }

  file { "${hdm::hdm_path}/db/production.sqlite3":
    ensure => file,
  }

  docker::image { 'ghcr.io/betadots/hdm':
    image_tag => $hdm::version,
  }

  docker::run { 'hdm':
    image    => "ghcr.io/betadots/hdm:${hdm::version}",
    env      => [
      "TZ=${$hdm::timezone}",
      "RAILS_DEVELOPMENT_HOSTS=${hdm::hostname}",
      "SECRET_KEY_BASE=${hdm::secret_key_base}",
    ],
    volumes  => [
      "${hdm::hdm_path}:${hdm::hdm_path}",
      "${hdm::puppet_code_dir}:${hdm::puppet_code_dir}:ro",
      "${hdm::hdm_path}/hdm.yml:/hdm/config/hdm.yml:ro",
      "${hdm::hdm_path}/database.yml:/hdm/config/database.yml:ro",
    ],
    hostname => $hdm::hostname,
    ports    => [$hdm::port],
    net      => 'host',
  }
}

# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include hdm::docker
#
# @api private
#
class hdm::docker {
  if $hdm::manage_docker {
    include docker
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
  }
  file { "${hdm::hdm_path}/database.yml":
    ensure  => file,
    content => epp('hdm/database.yml'),
  }
  file { "${hdm::hdm_path}/db/development.sqlite3":
    ensure => file,
  }

  docker::image { 'ghcr.io/betadots/hdm':
    image_tag => $hdm::version,
  }

  docker::run { 'hdm':
    image            => "ghcr.io/betadots/hdm:${hdm::version}",
    env              => [
      "TZ=${facts['timezone']}",
      "RAILS_DEVELOPMENT_HOSTS=${facts['networking']['fqdn']}",
    ],
    volumes          => [
      "${hdm::hdm_path}:${hdm::hdm_path}",
      "${hdm::puppet_code_dir}:${hdm::puppet_code_dir}:ro",
      "${hdm::hdm_path}/hdm.yml:/hdm/config/hdm.yml:ro",
      "${hdm::hdm_path}/database.yml:/hdm/config/database.yml:ro",
    ],
    hostname         => $facts['networking']['fqdn'],
    ports            => [$hdm::port],
    net              => 'host',
    extra_parameters => ["--user ${hdm::user}:${hdm::group}"]
  }
}

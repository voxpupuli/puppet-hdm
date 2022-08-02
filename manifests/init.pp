# @summary HDM installation main class
#
# This class controls the installation of HDM
#
# @example
#   include hdm
class hdm (
  Enum['docker', 'puppet-ruby'] $method = 'docker',
  Stdlib::Port                  $port = 3000,
){
  case $method {
    'docker': {
      include hdm::docker
    }
    'puppet-ruby': {
      include hdm::puppet_ruby
    }
    default: {
      fail('Unknown HDM installation method.')
    }
  }
}

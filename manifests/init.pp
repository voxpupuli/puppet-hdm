# @summary HDM installation main class
#
# This class controls the installation of HDM
#
# @param method Select the installation method.
#    Avalable methods: docker or puppet-ruby
#    When using puppet-ruby we install bundler gem into 
#    the puppet-agent ruby installation.
#
# @param manage_docker Set to false if this module should NOT
#   also include the docker class (without any arguments)
#   Please note that the docker module only works on Debian,
#   RedHat and windows systems.
#   SLES users must install and start docker via puppet package
#   and service resource.
#
# @param version Select the version to deploy.
#   Version is the image tag name when using docker and
#   the git tag when using puppet-ruby
#
# @param port The port where HDM should run on
#
# @param bind_ip The ip address to bind the process to
#
# @param hostname The hostname to use
#
# @param hdm_path Path where one wants to install and configure hdm
#
# @param git_url The git URL to clone the hdm repo from
#
# @param user The hdm user name
#
# @param group The hdm group name
#
# @param puppetdb_settings A hash to provide information on how
#   HDM can connect to puppetdb
#   The following options are possible:
#   Plain text (default)
#   ```
#     {
#       'server'           => 'http://localhost:8080',
#     }
#   ```
#   Using PE token:
#   ```
#     {
#       'server'           => 'https://localhost:8081',
#       'token'            => '/etc/hdm/puppetdb.token',
#       'cacert'           => '<path to cacert>',
#     }
#   ```
#   Using SSL cert:
#   ```
#     {
#       'server'           => 'http://localhost:8081',
#       'pem'              => {
#         'key'            => '/etc/hdm/ssl.key',
#         'cert'           => '/etc/hdm/ssl.cert',
#         'ca_file'        => '/etc/hdm/ssl.ca',
#       },
#     }
#   ```
#
# @param puppet_code_dir The path where HDM can find deployed 
#   Puppet environments (similar to puppet config code_dir)
#   defaults to '/etc/puppetlabs/code'
#
# @param allow_encryption Specify if HDM should use EYAML
#   Needs HDM access to EYAML keys (public and private)
#   Values for keys are taken from hiera.yaml file and can
#   not be set individually.
#
# @param read_only Set to false if you want the ability to 
#   change data via HDM webfrontend. WARNING!! untested!!!
#   Changes are stored via GIT.
#   Setting this to true also needs the git_data Array parameter
#
# @param git_data Configure several settings related to the option
#   to modify data via Webfrontend. WARNING!! untested!!
#   Required Array of hash data:
#   ```
#     [
#       {
#         'datadir'        => 'modules/hieradata/data',
#         'git_url'        => 'git@server:path/repo.git',
#         'path_in_repo'   => 'data',
#         'ssh_priv_key'   => '.ssh/id_rsa',
#       }
#     ]
#   ```
#
# @param ldap_settings Config for LDAP integration
#   Needs the following Hash:
#   ```
#     {
#       'host'             => 'localhost',
#       'port'             => 389,
#       'base_dn'          => 'ou=hdm,dc=nodomain',
#       'bind_dn'          => 'cn=admin,dc=nodomain',
#       'bind_dn_password' => 'openldap',
#     }
#   ```
#
# @param hdm_hiera_config_file Set to another file if you 
#   want HDM to not use hiera.yaml.
#
# @example
#   include hdm
class hdm (
  Enum['docker', 'puppet-ruby'] $method                = 'docker',
  Boolean                       $manage_docker         = true,
  String[1]                     $version               = 'main',
  Stdlib::Port                  $port                  = 3000,
  Stdlib::IP::Address::Nosubnet $bind_ip               = '0.0.0.0',
  String[1]                     $hostname              = $facts['networking']['fqdn'],
  Stdlib::Unixpath              $hdm_path              = '/etc/hdm',
  String[1]                     $user                  = 'hdm',
  String[1]                     $group                 = 'hdm',
  String[1]                     $git_url               = 'https://github.com/betadots/hdm.git',
  Hdm::Puppetdb                 $puppetdb_settings     = { 'server' => 'http://localhost:8080', },
  Stdlib::Unixpath              $puppet_code_dir       = '/etc/puppetlabs/code',
  String[1]                     $hdm_hiera_config_file = 'hiera.yaml',
  Boolean                       $allow_encryption      = false,
  Boolean                       $read_only             = true,
  Hdm::Gitdata                  $git_data              = [],
  Hdm::Ldap_settings            $ldap_settings         = {},
) {
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

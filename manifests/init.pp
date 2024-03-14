# @summary HDM installation main class
#
# This class controls the installation of HDM
#
# @param method Select the installation method.
#    Available methods: docker, rvm
#    When using rvm we install rvm into system and add the
#    bundler gem.
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
#   the git tag when using rvm
#   Please find the releases on HDM website: https://github.com/betadots/hdm/releases
#
# @param container_registry_url Configure another registry. Contains the host, path and container name. The version is set via the version parameter.
#   e.g. ghcr.io/betadots/hdm
#
# @param ruby_version Select the ruby version when installing using rvm
#   Please check [hdm ruby version requirement](https://github.com/betadots/hdm/blob/main/.ruby-version)
#
# @param port The port where HDM should run on
#
# @param bind_ip The ip address to bind the process to
#
# @param hostname The HDM webservice hostname
#
# @param timezone THe timezone to use when running with docker
#
# @param hdm_path Path where one wants to install and configure hdm
#
# @param secret_key_base A secret key. Key can be generated using `openssl rand -hex 16`
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
#       'server'           => 'https://localhost:8081',
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
# @param disable_authentication Disable user and login
#   This makes HDM available to anyone.
#
# @param allow_encryption Specify if HDM should use EYAML
#   Needs HDM access to EYAML keys (public and private)
#   Values for keys are taken from hiera.yaml file and can
#   not be set individually.
#
# @param read_only Set to false if you want the ability to
#   change data via HDM webfrontend.
#   WARNING!! setting to true is untested!!!
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
#       'bind_dn_password' => 'openldap', # clear text
#       'ldaps'            =>  false,
#     }
#   ```
#
# @param ldap_bind_dn_password set sensitive password for ldap bind
#
# @param hdm_hiera_config_file Set to another file if you
#   want HDM to not use hiera.yaml.
#
# @param custom_lookup_function If you use your own developed hiera
#   lookup function, HDM needs to know if the function returns yaml
#   or eyaml data.
#   Example:
#   ```
#     {
#       'functon_name' => '<yaml|eyaml>'
#     }
#
# @example
#   include hdm
class hdm (
  # installation parameter
  String[1]                     $version               = '1.0.1',
  Enum['docker', 'rvm']         $method                = 'docker',
  String[1]                     $container_registry_url = 'ghcr.io/betadots/hdm',
  Boolean                       $manage_docker         = true,
  String[1]                     $ruby_version          = '3.1.2',
  # required application parameter
  Stdlib::Port                  $port                  = 3000,
  Stdlib::IP::Address::Nosubnet $bind_ip               = '0.0.0.0',
  String[1]                     $hostname              = $facts['networking']['fqdn'],
  String[1]                     $timezone              = $facts['timezone'],
  Stdlib::Unixpath              $hdm_path              = '/etc/hdm',
  String[1]                     $secret_key_base       = '7a8509ab31fdb0c15c71c941d089474a',
  String[1]                     $user                  = 'hdm',
  String[1]                     $group                 = 'hdm',
  String[1]                     $git_url               = 'https://github.com/betadots/hdm.git',
  Hdm::Puppetdb                 $puppetdb_settings     = { 'server' => 'http://localhost:8080', },
  Stdlib::Unixpath              $puppet_code_dir       = '/etc/puppetlabs/code',
  String[1]                     $hdm_hiera_config_file = 'hiera.yaml',
  # additional application parameter
  Boolean                        $disable_authentication = false,
  Boolean                        $allow_encryption       = false,
  Boolean                        $read_only              = true,
  Optional[Hdm::Gitdata]         $git_data               = undef,
  Optional[Hdm::Ldap_settings]   $ldap_settings          = undef,
  Optional[Sensitive[String[1]]] $ldap_bind_dn_password  = undef,
  Hash[String[1],Enum['yaml', 'eyaml']]  $custom_lookup_function = {},
) {
  if $ldap_settings {
    if $ldap_bind_dn_password {
      $final_ldap_settings = $ldap_settings + { bind_dn_password => $ldap_bind_dn_password }
    } else {
      $final_ldap_settings = $ldap_settings
    }
  } else {
    $final_ldap_settings = {}
  }

  case $method {
    'docker': {
      $run_mode = 'production'
      include hdm::docker
    }
    'rvm': {
      $run_mode = 'development'
      include hdm::rvm
    }
    default: {
      fail('Unknown HDM installation method.')
    }
  }
}

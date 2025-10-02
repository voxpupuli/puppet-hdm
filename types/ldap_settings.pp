# @summary type to enforce ldap settings for HDM
type Hdm::Ldap_settings = Struct[
  {
    'host'               => Stdlib::Host,
    'port'               => Stdlib::Port,
    'base_dn'            => String[1],
    'bind_dn'            => String[1],
    'bind_dn_password'   => Optional[Variant[Sensitive[String[1]],String[1]]],
    'ssl_mode'           => Optional[Enum['start_tls', 'simple']],
    'ssl_verify'         => Optional[Boolean],
    'username_attribute' => Optional[String[1]],
    'ca_file'            => Optional[Stdlib::Absolutepath],
    'filter'             => Optional[String[1]],
  }
]

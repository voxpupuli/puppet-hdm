# @summary type to enforce ldap settings for HDM
type Hdm::Ldap_settings = Struct[
  {
    'host'             => Stdlib::Host,
    'port'             => Stdlib::Port,
    'base_dn'          => String[1],
    'bind_dn'          => String[1],
    'bind_dn_password' => Optional[Variant[Sensitive[String[1]],String[1]]],
    'ldaps'            => Boolean,
  }
]

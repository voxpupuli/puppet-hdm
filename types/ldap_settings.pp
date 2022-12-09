# @summary type to enforce ldap settings for HDM
type Hdm::Ldap_settings = Struct[
  {
    Optional[host]             => Stdlib::Host,
    Optional[port]             => Stdlib::Port,
    Optional[base_dn]          => String[1],
    Optional[bind_dn]          => String[1],
    Optional[bind_dn_password] => String[1],
    'ldaps'                    => Boolean,
  }
]

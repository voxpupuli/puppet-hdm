# @summary type to enforce puppetdb settings for HDM
type Hdm::Puppetdb = Struct[
  {
    server           => Stdlib::Httpurl,
    Optional[pem]    => Struct[
      {
        key     => Stdlib::Unixpath,
        cert    => Stdlib::Unixpath,
        ca_file => Stdlib::Unixpath,
      }
    ],
    Optional[token]  => Stdlib::Unixpath,
    Optional[cacert] => Stdlib::Unixpath,
  }
]

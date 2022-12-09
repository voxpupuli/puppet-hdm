# @summary type to enforce git settings for HDM
type Hdm::Gitdata = Array[
  Struct[
    {
      datadir                => Stdlib::Unixpath,
      git_url                => String[1],
      path_in_repo           => String[1],
      Optional[ssh_priv_key] => String[1],
    }
  ]
]

type Hdm::Gitdata = Array[
 Optional[Struct[
    {
      datadir                => Stdlib::Unixpath,
      git_url                => String[1],
      path_in_repo           => String[1],
      Optional[ssh_priv_key] => String[1],
    }
  ]]
]

# class hdm::rvm
class hdm::rvm {
  group { $hdm::group:
    ensure => present,
  }
  user { $hdm::user:
    ensure => present,
    shell  => '/sbin/nologin',
    home   => $hdm::hdm_path,
    gid    => $hdm::group,
  }
  file { $hdm::hdm_path:
    ensure => directory,
    owner  => $hdm::user,
    group  => $hdm::group,
  }
  include gnupg
  include rvm
  rvm::system_user { 'hdm': }
  rvm_system_ruby { "ruby-${hdm::ruby_version}":
    ensure      => present,
    default_use => false,
  }
  rvm_gem { 'bundler':
    ensure       => present,
    ruby_version => "ruby-${hdm::ruby_version}",
    require      => Rvm_system_ruby["ruby-${hdm::ruby_version}"],
  }
}

# puppet-hdm

[![Build Status](https://github.com/voxpupuli/puppet-hdm/workflows/CI/badge.svg)](https://github.com/voxpupuli/puppet-hdm/actions?query=workflow%3ACI)
[![Release](https://github.com/voxpupuli/puppet-hdm/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-hdm/actions/workflows/release.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/puppet-hdm)
[![Apache-2 License](https://img.shields.io/github/license/voxpupuli/puppet-hdm.svg)](LICENSE)
[![By betadots](https://img.shields.io/badge/by-betadots-fb7047.svg)](#transfer-notice)

## Table of Contents

- [puppet-hdm](#puppet-hdm)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Major Update](#major-update)
  - [Setup](#setup)
    - [Setup Requirements](#setup-requirements)
    - [SLES and Docker module](#sles-and-docker-module)
    - [Beginning with betadots HDM](#beginning-with-betadots-hdm)
  - [Reference](#reference)
  - [Limitations](#limitations)
  - [Transfer Notice](#transfer-notice)
  - [License](#license)

## Description

This module manages the betadots [HDM](https://github.com/betadots/hdm) installation.

HDM can be installed on Puppet Server or on any other system with PuppetDB access and Puppet code deployed.

This module allows you to either make use of the betadots HDM Docker container or to install HDM using RVM.

## Major Update

As of version 1.0.0 and newer the HDM Docker container runs in production mode.
Existing installations using HDM container prior version 1.0.0 must prepare this change by copying the development.sqlite3 file to production.sqlite3

```shell
cp /etc/hdm/development.sqlite3 /etc/hdm/production.sqlite3
```

Now Puppet can configure the system.
Once HDM is up and running the database can be changed from development to production:

```shell
docker exec -ti hdm /hdm/bin/rails db:environment:set RAILS_ENV=production
```

After the update and checking functionality the development.sqlite3 file can be deleted.

## Setup

### Setup Requirements

The puppet-hdm module needs puppetlabs/stdlib as we use some of the stdlib data types.

If you want to make use of the docker container, you need the following module:

- puppetlabs/docker - min version 4.4.0 - tested with v10.1.0

If you want to install HDM using RVM, you need the following modules:

- puppet/rvm - min version 3.0.0
- golja/gnupg - min version 1.2.3 - for Puppet 8 a fork must be used: see https://github.com/dgolja/golja-gnupg/pull/42 and use https://github.com/flepoutre/golja-gnupg - master branch
- puppetlabs/vcsrepo - min version 7.0.0
- puppet/systemd     - min version 8.1.0

### SLES and Docker module

The [puppetlabs-docker](https://forge.puppet.com/modules/puppetlabs/docker/readme) Module lacks official SLES and SuSe support. Yet: the module is usable on SLES.

The installation of Docker can not be done using the module on SLES.
Instead one must install Docker separately within a profile class.

But any other defined type like `docker::image` or `docker::run` is working.

One **must** set the `acknowledge_unsupported_os` parameter to `true` to prevent the Docker module from failing on SuSe systems.

Hiera:

```yaml
---
# Allow Docker to work on SLES
docker::acknowledge_unsupported_os: true
```

### Beginning with betadots HDMA

#### Container

The most simple approach is to just include the hdm class and provide the version parameter:

```puppet
include hdm
```

You can find the released versions on [HDM releases page](https://github.com/betadots/hdm/releases)
```yaml
hdm::version: '3.1.0
```

Another option is to use class resource type declaration:

```puppet
class { 'hdm':
  version => '3.1.0',
}
```

This will install HDM as docker container.

#### RVM

To run HDM directly from source, we recommend to use the vagrant setup in HDM repository.

Or: use the following Puppet configuration:

```ruby
# Puppetfile
# mod 'golja-gnupg',  '1.2.3'
mod 'gnupg', :git => 'https://github.com/flepoutre/golja-gnupg.git', :branch => 'master'
mod 'ipcrm-echo', '0.1.8'
mod 'puppet-hdm', :git => 'https://github.com/voxpupuli/puppet-hdm.git', :branch => 'fix_rvm'
mod 'puppet-rvm', '3.0.0'
mod 'puppet-systemd', '8.1.0'
mod 'puppetlabs-apt', '10.0.1'
mod 'puppetlabs-concat', '9.1.0'
mod 'puppetlabs-docker', '10.1.0'
mod 'puppetlabs-firewall', '8.1.4'
mod 'puppetlabs-inifile', '6.2.0'
mod 'puppetlabs-postgresql', '10.5.0'
mod 'puppetlabs-puppetdb', '8.1.0'
mod 'puppetlabs-stdlib', '9.7.0'
mod 'puppetlabs-vcsrepo'
```

```puppet
# manifests/site.pp
File {
  backup => false,
}
$classes_hash = lookup('classes', { 'value_type' => Hash, 'default_value' => {} })
$classes_hash.keys.sort.each |$key| {
  if $classes_hash[$key] != '' {
    contain $classes_hash[$key]
  } else {
    echo { $key:
      message  => "Class for ${key} on ${facts['networking']['fqdn']} is disabled",
      withpath => false,
    }
  }
}
node default {}
```

```yaml
# hiera.yaml
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "Per-node data (yaml version)"
    path: "nodes/%{::trusted.certname}.yaml"
  - name: "Other YAML hierarchy levels"
    paths:
      - "common.yaml"
```

```yaml
# data/nodes/<certname>.yaml
---
classes:
  '90_hdm_class': 'hdm'
  '91_puppetdb_class': 'puppetdb'
  '92_puppetdb_master_class': 'puppetdb::master::config'

hdm::version: 'main'
hdm::method: 'rvm'
hdm::ruby_version: '3.4.2'
hdm::disable_authentication: true

# using with foreman
puppetdb::manage_firewall: false
puppetdb::postgres_version: '13'
puppetdb::manage_package_repo: false
postgresql::globals::manage_dnf_module: false
```

## Reference

Please check the [REFERENCE.md](REFERENCE.md) file.

## Limitations

On SLES we can not use the puppetlabs/docker module fpr installation, but is still needed to pull the image and run the container..
Instead set the manage_docker parameter to false and take care on docker package and service by yourself.

## Transfer Notice

This Puppet module was originally authored by [betadots GmbH](https://www.betadots.de).
The maintainer preferred that Vox Pupuli take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of github.com/betadots/puppet-hdm.

## License

This module is licensed under the Apache-2 license.

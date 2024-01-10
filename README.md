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

- puppetlabs/docker - min version 4.4.0

If you want to install HDM using RVM, you need the following modules:

- puppet/rvm - min version 2.0.0
- golja/gnupg - min version 1.2.3
- puppetlabs/vcsrepo - min version 5.2.0
- puppet/systemd     - min version 3.10.0

### SLES and Docker module

The [puppetlabs-docker](https://forge.puppet.com/modules/puppetlabs/docker/readme) Module lacks official SLES and SuSe support. Yet: the module is usable on SLES.

The installation of Docker can not be done using the module on SLES.
But one can use any other defined type like `docker::image` or `docker::run`.

One **must** set the `acknowledge_unsupported_os` parameter to `false` and must tell the module to not manage the docker installation.

To allow full functionality, the hdm parameter for `manage_docker` must be set to `true`, as we deactivate this in module data.

Hiera:

```yaml
---
# Allow Docker to work on SLES
docker::acknowledge_unsupported_os: true
docker::manage_package: false
# Enable HDM to use docker module on SLES
hdm::manage_docker: true
```

### Beginning with betadots HDM

The most simple approach is to just include the hdm class and provide the version parameter:

```puppet
include hdm
```

You can find the released versions on [HDM releases page](https://github.com/betadots/hdm/releases)
```yaml
hdm::version: '1.0.1
```

Another option is to use class resource type declaration:

```puppet
class { 'hdm':
  version => '1.0.1',
}
```

This will install HDM as docker container.

## Reference

Please check the [REFERENCE.md](REFERENCE.md) file.

## Limitations

On SLES we can not use the puppetlabs/docker module.
Instead set the manage_docker parameter to false and take care on docker package and service by yourself.

## Transfer Notice

This Puppet module was originally authored by [betadots GmbH](https://www.betadots.de).
The maintainer preferred that Vox Pupuli take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of github.com/betadots/puppet-hdm.

## License

This module is licensed under the Apache-2 license.

# puppet-hdm

[![Build Status](https://github.com/voxpupuli/puppet-hdm/workflows/CI/badge.svg)](https://github.com/voxpupuli/puppet-hdm/actions?query=workflow%3ACI)
[![Release](https://github.com/voxpupuli/puppet-hdm/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-hdm/actions/workflows/release.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/hdm.svg)](https://forge.puppetlabs.com/puppet/hdm)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/puppet-hdm)
[![Apache-2 License](https://img.shields.io/github/license/puppet/puppet-hdm.svg)](LICENSE)
[![By betadots](https://img.shields.io/badge/by-betadots-fb7047.svg)](#transfer-notice)

## Table of Contents

- [puppet-hdm](#puppet-hdm)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Major Update](#major-update)
  - [Setup](#setup)
    - [Setup Requirements](#setup-requirements)
    - [Beginning with hdm](#beginning-with-hdm)
  - [Reference](#reference)
  - [Limitations](#limitations)
  - [Transfer Notice](#transfer-notice)
  - [License](#license)

## Description

This module manages [HDM](https://github.com/betadots/hdm) installation.

HDM can be installed on Puppet Server or on any other system with PuppetDB access and Puppet code deployed.

This module allows you to either make use of the HDM Docker container or to install HDM using RVM.

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

### Beginning with hdm

The most simple approach is to just include the hdm class:

```puppet
include hdm
```

This will install HDM as docker container.

## Reference

Please check the [REFERENCE.md](REFERENCE.md) file.

## Limitations

On SLES we can not use the puppetlabs/docker module.
Instead set the manage_docker parameter to false and take care on docker package and service by yourself.

## Transfer Notice

This plugin was originally authored by [betadots GmbH](https://www.betadots.de).
The maintainer preferred that Vox Pupuli take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Puppet Inc.

## License

This module is licensed under the Apache-2 license.

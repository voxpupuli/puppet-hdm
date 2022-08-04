# puppet-hdm

## Table of Contents

- [puppet-hdm](#puppet-hdm)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [Setup Requirements](#setup-requirements)
    - [Beginning with hdm](#beginning-with-hdm)
  - [Reference](#reference)
  - [Limitations](#limitations)

## Description

This module manages [HDM](https://github.com/betadots/hdm) installation.

HDM can be installed on Puppet Server or on any other system with PuppetDB access and Puppet code deployed.

This module allows you to either make use of the HDM Docker container or to install HDM using the Puppet Agent Ruby installation.

## Setup

### Setup Requirements

The puppet-hdm module needs puppetlabs/stdlib as we use some of the stdlib data types.

If you want to make use of the docker container, you need the following module:

- puppetlabs/docker - min version 4.4.0

If you want to install HDM using Puppet Ruby, you need the following modules:

- puppetlabs/vcsrepo - min version 5.2.0
- puppet/systemd     - min version 3.10.0

### Beginning with hdm

The most simple approach is to just include the hdm class:

    include hdm

This will install HDM as docker container.

## Reference

Please check the [REFERENCE.md](REFERENCE.md) file.

## Limitations

On SLES we can not use the puppetlabs/docker module.
Instead set the manage_docker parameter to false and take care on docker package and service by yourself.

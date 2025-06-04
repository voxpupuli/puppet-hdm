# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v3.4.0](https://github.com/voxpupuli/puppet-hdm/tree/v3.4.0) (2025-06-04)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v3.3.0...v3.4.0)

**Breaking changes:**

- fix rvm setup, drop EOL EL systems [\#103](https://github.com/voxpupuli/puppet-hdm/pull/103) ([tuxmea](https://github.com/tuxmea))

**Implemented enhancements:**

- Add additional mounts for docker [\#111](https://github.com/voxpupuli/puppet-hdm/pull/111) ([tuxmea](https://github.com/tuxmea))
- Allow puppetlabs/apt 10.x [\#108](https://github.com/voxpupuli/puppet-hdm/pull/108) ([smortex](https://github.com/smortex))
- Update HDM 3.0.0-\>3.2.0 [\#106](https://github.com/voxpupuli/puppet-hdm/pull/106) ([bastelfreak](https://github.com/bastelfreak))
- metadata.json: Add OpenVox [\#105](https://github.com/voxpupuli/puppet-hdm/pull/105) ([jstraw](https://github.com/jstraw))
- Add global\_hiera\_yaml parameter [\#92](https://github.com/voxpupuli/puppet-hdm/pull/92) ([tuxmea](https://github.com/tuxmea))

**Closed issues:**

- PE with versioned deploys need code dir array [\#110](https://github.com/voxpupuli/puppet-hdm/issues/110)

**Merged pull requests:**

- puppet/systemd: allow 8.x [\#101](https://github.com/voxpupuli/puppet-hdm/pull/101) ([jay7x](https://github.com/jay7x))

## [v3.3.0](https://github.com/voxpupuli/puppet-hdm/tree/v3.3.0) (2024-11-21)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v3.2.0...v3.3.0)

**Implemented enhancements:**

- Updates on config and spec [\#98](https://github.com/voxpupuli/puppet-hdm/pull/98) ([tuxmea](https://github.com/tuxmea))
- Update ruby version and hdm version defaults [\#89](https://github.com/voxpupuli/puppet-hdm/pull/89) ([rwaffen](https://github.com/rwaffen))
- Add Puppet 8 support [\#87](https://github.com/voxpupuli/puppet-hdm/pull/87) ([zilchms](https://github.com/zilchms))
- puppetlabs/docker: Allow 9.x [\#86](https://github.com/voxpupuli/puppet-hdm/pull/86) ([zilchms](https://github.com/zilchms))
- puppetlabs/vcsrepo: Allow 6.x [\#85](https://github.com/voxpupuli/puppet-hdm/pull/85) ([zilchms](https://github.com/zilchms))
- puppet/systemd: Allow 6.x [\#84](https://github.com/voxpupuli/puppet-hdm/pull/84) ([zilchms](https://github.com/zilchms))
- puppet/rvm: Allow 3.x [\#83](https://github.com/voxpupuli/puppet-hdm/pull/83) ([zilchms](https://github.com/zilchms))
- puppetlabs/stdlib: allow 9.x [\#82](https://github.com/voxpupuli/puppet-hdm/pull/82) ([zilchms](https://github.com/zilchms))

**Merged pull requests:**

- Update HDM [\#96](https://github.com/voxpupuli/puppet-hdm/pull/96) ([tuxmea](https://github.com/tuxmea))
- update puppet-systemd upper bound to 8.0.0 [\#91](https://github.com/voxpupuli/puppet-hdm/pull/91) ([TheMeier](https://github.com/TheMeier))

## [v3.2.0](https://github.com/voxpupuli/puppet-hdm/tree/v3.2.0) (2024-03-14)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v3.1.0...v3.2.0)

**Implemented enhancements:**

- Manage option to use a custom lookup function [\#80](https://github.com/voxpupuli/puppet-hdm/pull/80) ([tuxmea](https://github.com/tuxmea))
- HDM supports disabling authentication. [\#77](https://github.com/voxpupuli/puppet-hdm/pull/77) ([tuxmea](https://github.com/tuxmea))

## [v3.1.0](https://github.com/voxpupuli/puppet-hdm/tree/v3.1.0) (2024-01-11)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v3.0.0...v3.1.0)

**Implemented enhancements:**

- Sles support [\#75](https://github.com/voxpupuli/puppet-hdm/pull/75) ([tuxmea](https://github.com/tuxmea))
- Update container env [\#72](https://github.com/voxpupuli/puppet-hdm/pull/72) ([tuxmea](https://github.com/tuxmea))

**Closed issues:**

- SLES Support missing in docker implementation [\#68](https://github.com/voxpupuli/puppet-hdm/issues/68)

**Merged pull requests:**

- Add description to use hdm module on SLES [\#74](https://github.com/voxpupuli/puppet-hdm/pull/74) ([tuxmea](https://github.com/tuxmea))
- Add Suse support [\#71](https://github.com/voxpupuli/puppet-hdm/pull/71) ([tuxmea](https://github.com/tuxmea))

## [v3.0.0](https://github.com/voxpupuli/puppet-hdm/tree/v3.0.0) (2023-06-19)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v2.2.1...v3.0.0)

**Breaking changes:**

- Drop Puppet 6 support [\#56](https://github.com/voxpupuli/puppet-hdm/pull/56) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Allow setting of different hiera.yaml to use [\#60](https://github.com/voxpupuli/puppet-hdm/pull/60) ([tuxmea](https://github.com/tuxmea))
- Switch version from main to fix version. [\#54](https://github.com/voxpupuli/puppet-hdm/pull/54) ([tuxmea](https://github.com/tuxmea))

## [v2.2.1](https://github.com/voxpupuli/puppet-hdm/tree/v2.2.1) (2023-02-17)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v2.2.0...v2.2.1)

**Merged pull requests:**

- README.md: Fix license badge [\#49](https://github.com/voxpupuli/puppet-hdm/pull/49) ([bastelfreak](https://github.com/bastelfreak))

## [v2.2.0](https://github.com/voxpupuli/puppet-hdm/tree/v2.2.0) (2023-02-17)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v2.1.2...v2.2.0)

**Implemented enhancements:**

- puppet-lint: validate docs and datatypes [\#48](https://github.com/voxpupuli/puppet-hdm/pull/48) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- Update documentation: make more clear where the product originates from [\#47](https://github.com/voxpupuli/puppet-hdm/pull/47) ([rwaffen](https://github.com/rwaffen))
- .fixtures.yml: Migrate from forge releases to git [\#45](https://github.com/voxpupuli/puppet-hdm/pull/45) ([bastelfreak](https://github.com/bastelfreak))
- Migrate module from betadots to Vox Pupuli [\#44](https://github.com/voxpupuli/puppet-hdm/pull/44) ([bastelfreak](https://github.com/bastelfreak))
- puppet/systemd: Allow 4.x [\#43](https://github.com/voxpupuli/puppet-hdm/pull/43) ([bastelfreak](https://github.com/bastelfreak))

## [v2.1.2](https://github.com/voxpupuli/puppet-hdm/tree/v2.1.2) (2023-02-16)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v2.1.1...v2.1.2)

**Implemented enhancements:**

- Update Gems + CI config [\#39](https://github.com/voxpupuli/puppet-hdm/pull/39) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- workaround "sensitive in hash" [\#38](https://github.com/voxpupuli/puppet-hdm/pull/38) ([rwaffen](https://github.com/rwaffen))

**Closed issues:**

- Adapt changes from HDM [\#30](https://github.com/voxpupuli/puppet-hdm/issues/30)

**Merged pull requests:**

- Fix syntax highlighting in README.md [\#37](https://github.com/voxpupuli/puppet-hdm/pull/37) ([bastelfreak](https://github.com/bastelfreak))

## [v2.1.1](https://github.com/voxpupuli/puppet-hdm/tree/v2.1.1) (2023-01-31)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v2.0.2...v2.1.1)

**Merged pull requests:**

- minor update and new release [\#36](https://github.com/voxpupuli/puppet-hdm/pull/36) ([tuxmea](https://github.com/tuxmea))
- fixes for production [\#35](https://github.com/voxpupuli/puppet-hdm/pull/35) ([tuxmea](https://github.com/tuxmea))
- Release v2.0.0 [\#34](https://github.com/voxpupuli/puppet-hdm/pull/34) ([tuxmea](https://github.com/tuxmea))

## [v2.0.2](https://github.com/voxpupuli/puppet-hdm/tree/v2.0.2) (2023-01-30)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v2.0.1...v2.0.2)

## [v2.0.1](https://github.com/voxpupuli/puppet-hdm/tree/v2.0.1) (2023-01-30)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v2.0.0...v2.0.1)

## [v2.0.0](https://github.com/voxpupuli/puppet-hdm/tree/v2.0.0) (2023-01-30)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.2.3...v2.0.0)

**Closed issues:**

- mark passwords as sensitive [\#22](https://github.com/voxpupuli/puppet-hdm/issues/22)

**Merged pull requests:**

- preparation for v1 container running in production mode [\#33](https://github.com/voxpupuli/puppet-hdm/pull/33) ([tuxmea](https://github.com/tuxmea))
- Add badges to README.md [\#32](https://github.com/voxpupuli/puppet-hdm/pull/32) ([bastelfreak](https://github.com/bastelfreak))
- update docker and apt module versions [\#31](https://github.com/voxpupuli/puppet-hdm/pull/31) ([tuxmea](https://github.com/tuxmea))
- restart if config file changes [\#29](https://github.com/voxpupuli/puppet-hdm/pull/29) ([tuxmea](https://github.com/tuxmea))
- improve data types [\#28](https://github.com/voxpupuli/puppet-hdm/pull/28) ([tuxmea](https://github.com/tuxmea))
- Manage changelog [\#27](https://github.com/voxpupuli/puppet-hdm/pull/27) ([tuxmea](https://github.com/tuxmea))
- prepare v1.2.3 [\#26](https://github.com/voxpupuli/puppet-hdm/pull/26) ([tuxmea](https://github.com/tuxmea))
- Create LICENSE [\#14](https://github.com/voxpupuli/puppet-hdm/pull/14) ([tuxmea](https://github.com/tuxmea))
- Update issue templates [\#13](https://github.com/voxpupuli/puppet-hdm/pull/13) ([tuxmea](https://github.com/tuxmea))
- Create CODE\_OF\_CONDUCT.md [\#12](https://github.com/voxpupuli/puppet-hdm/pull/12) ([tuxmea](https://github.com/tuxmea))

## [v1.2.3](https://github.com/voxpupuli/puppet-hdm/tree/v1.2.3) (2022-12-09)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.2.2...v1.2.3)

**Closed issues:**

- ldaps config not working [\#23](https://github.com/voxpupuli/puppet-hdm/issues/23)

## [v1.2.2](https://github.com/voxpupuli/puppet-hdm/tree/v1.2.2) (2022-12-09)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.2.1...v1.2.2)

**Implemented enhancements:**

- Add assert\_private\(\) to private classes [\#17](https://github.com/voxpupuli/puppet-hdm/pull/17) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Debian Docker: Configure correct shell for hdm user [\#20](https://github.com/voxpupuli/puppet-hdm/pull/20) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- add missing parameter for ldap [\#24](https://github.com/voxpupuli/puppet-hdm/pull/24) ([tuxmea](https://github.com/tuxmea))

## [v1.2.1](https://github.com/voxpupuli/puppet-hdm/tree/v1.2.1) (2022-08-10)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.2.0...v1.2.1)

**Merged pull requests:**

- Release v1.2.1 [\#16](https://github.com/voxpupuli/puppet-hdm/pull/16) ([tuxmea](https://github.com/tuxmea))
- Update documentation [\#15](https://github.com/voxpupuli/puppet-hdm/pull/15) ([tuxmea](https://github.com/tuxmea))

## [v1.2.0](https://github.com/voxpupuli/puppet-hdm/tree/v1.2.0) (2022-08-08)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.1.0...v1.2.0)

**Merged pull requests:**

- update new release to v1.2.0 [\#11](https://github.com/voxpupuli/puppet-hdm/pull/11) ([tuxmea](https://github.com/tuxmea))
- installation via RVM [\#10](https://github.com/voxpupuli/puppet-hdm/pull/10) ([tuxmea](https://github.com/tuxmea))
- new release v1.1.1 [\#9](https://github.com/voxpupuli/puppet-hdm/pull/9) ([tuxmea](https://github.com/tuxmea))

## [v1.1.0](https://github.com/voxpupuli/puppet-hdm/tree/v1.1.0) (2022-08-04)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.0.3...v1.1.0)

**Merged pull requests:**

- Disable puppet-ruby [\#8](https://github.com/voxpupuli/puppet-hdm/pull/8) ([tuxmea](https://github.com/tuxmea))
- puppet-ruby typo npoc -\> nproc [\#7](https://github.com/voxpupuli/puppet-hdm/pull/7) ([tuxmea](https://github.com/tuxmea))

## [v1.0.3](https://github.com/voxpupuli/puppet-hdm/tree/v1.0.3) (2022-08-04)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.0.2...v1.0.3)

**Merged pull requests:**

- Documentation [\#6](https://github.com/voxpupuli/puppet-hdm/pull/6) ([tuxmea](https://github.com/tuxmea))
- Bugfixes [\#5](https://github.com/voxpupuli/puppet-hdm/pull/5) ([tuxmea](https://github.com/tuxmea))

## [v1.0.2](https://github.com/voxpupuli/puppet-hdm/tree/v1.0.2) (2022-08-04)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.0.1...v1.0.2)

## [v1.0.1](https://github.com/voxpupuli/puppet-hdm/tree/v1.0.1) (2022-08-04)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/v1.0.0...v1.0.1)

**Merged pull requests:**

- correct module version dependencies [\#4](https://github.com/voxpupuli/puppet-hdm/pull/4) ([tuxmea](https://github.com/tuxmea))

## [v1.0.0](https://github.com/voxpupuli/puppet-hdm/tree/v1.0.0) (2022-08-03)

[Full Changelog](https://github.com/voxpupuli/puppet-hdm/compare/f617471f6dd589d2259a7760d64604f73c6268b0...v1.0.0)

**Merged pull requests:**

- Use hdm data types on complex hashes and arrays [\#3](https://github.com/voxpupuli/puppet-hdm/pull/3) ([tuxmea](https://github.com/tuxmea))
- Add GitHub actions [\#2](https://github.com/voxpupuli/puppet-hdm/pull/2) ([tuxmea](https://github.com/tuxmea))
- Docker [\#1](https://github.com/voxpupuli/puppet-hdm/pull/1) ([tuxmea](https://github.com/tuxmea))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*

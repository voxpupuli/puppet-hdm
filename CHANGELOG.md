# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

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

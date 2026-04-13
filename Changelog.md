# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- RBS type signatures shipped with the gem
- Support for Ruby 3.3, 3.4, and 4.0
- Gemspec metadata (`rubygems_mfa_required`, `source_code_uri`, `changelog_uri`)
- Steep strict-mode type checking
- Mutant mutation testing with full operators and 100% coverage
- Yardstick documentation coverage enforcement at 100%
- RuboCop with performance, rake, rspec, and thread_safety extensions
- Dependabot configuration for GitHub Actions and Bundler
- GitHub Actions workflows for specs, mutant, rubocop, steep, yardstick, and gem push
- `frozen_string_literal: true` on all Ruby files

### Changed

- Require Ruby >= 3.3 (dropped support for Ruby < 3.3)
- Require RubyGems >= 3.3.26
- RSpec dependency broadened to `>= 3, < 5` (compatible with RSpec 4)
- `InstanceMethods#with` uses `Hash#merge` instead of `Hash#update`
- Simplified `included` hook implementation
- Improved YARD documentation with `@example` tags and accurate return types

### Removed

- `abstract_type` runtime dependency (was required but unused)
- Legacy CI configurations (Travis CI, CircleCI)
- `devtools` dependency and associated config files (`config/flay.yml`, `config/flog.yml`, `config/reek.yml`, `config/rubocop.yml`, `config/yardstick.yml`)

## [0.3.2] - 2020-09-10

### Changed

- Packaging no longer relies on git

## [0.3.1] - 2018-02-15

### Fixed

- Falsy key match detection

## [0.3.0] - 2015-09-04

### Added

- `#with` as a replacement for `Anima::Update` that is active by default

### Removed

- Support for Ruby < 2.1
- `Anima::Update`

## [0.2.1] - 2014-04-10

### Changed

- Require Ruby >= 1.9.3 in gemspec

## [0.2.0] - 2014-01-13

### Changed

- Replace `AnimaInfectedClass.attributes_hash(instance)` with `AnimaInfectedClass#to_h`

### Removed

- `AnimaInfectedClass.attributes_hash(instance)`

## [0.1.1] - 2013-09-08

### Changed

- Refactor internals

## [0.1.0] - 2013-09-08

### Changed

- Update dependencies

## [0.0.6] - 2013-02-18

### Added

- Support for updates via `Anima::Update` mixin

### Changed

- Update dependencies

## [0.0.5] - 2013-02-17

### Changed

- Update dependencies

## [0.0.4] - 2013-01-21

### Changed

- Update dependencies

## [0.0.3] - 2012-12-13

### Changed

- Use the `attributes_hash` naming consistently

## [0.0.2] - 2012-12-13

First public release!

[Unreleased]: https://github.com/mbj/anima/compare/v0.3.2...HEAD
[0.3.2]: https://github.com/mbj/anima/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/mbj/anima/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/mbj/anima/compare/v0.2.1...v0.3.0
[0.2.1]: https://github.com/mbj/anima/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/mbj/anima/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/mbj/anima/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/mbj/anima/compare/v0.0.6...v0.1.0
[0.0.6]: https://github.com/mbj/anima/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/mbj/anima/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/mbj/anima/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mbj/anima/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mbj/anima/releases/tag/v0.0.2

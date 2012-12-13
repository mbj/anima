# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'anima'
  s.version  = '0.0.3'

  s.authors  = ['Markus Schirp']
  s.email    = 'mbj@seonic.net'
  s.summary  = 'Attributes for Plain Old Ruby Objects Experiment'
  s.homepage = 'http://github.com/mbj/anima'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)
  s.extra_rdoc_files = %w(README.md)

  s.add_dependency('backports',     '~> 2.6.4')
  s.add_dependency('adamantium',    '~> 0.0.3')
  s.add_dependency('equalizer',     '~> 0.0.1')
  s.add_dependency('abstract_type', '~> 0.0.2')
end

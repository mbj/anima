# encoding: utf-8

Gem::Specification.new do |s|
  s.name = 'anima'
  s.version  = '0.2.0'

  s.authors  = ['Markus Schirp']
  s.email    = 'mbj@schirp-dso.com'
  s.summary  = 'Initialize object attributes via attributes hash'
  s.homepage = 'http://github.com/mbj/anima'
  s.license  = 'MIT'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)
  s.extra_rdoc_files = %w(README.md)

  s.add_dependency('adamantium',    '~> 0.1')
  s.add_dependency('equalizer',     '~> 0.0.8')
  s.add_dependency('abstract_type', '~> 0.0.7')
end

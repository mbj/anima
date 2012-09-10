# -*- encoding: utf-8 -*-
require File.expand_path('../lib/anima/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'anima'
  s.version = Anima::VERSION.dup

  s.authors  = ['Markus Schirp']
  s.email    = 'mbj@seonic.net'
  s.summary  = 'Attributes for Plain Old Ruby Objects Experiment'
  s.homepage = 'http://github.com/mbj/anima'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)
  s.extra_rdoc_files = %w(README)

  s.add_dependency('backports')
  s.add_dependency('immutable', '~> 0.0.1')
  s.add_dependency('abstract_class', '~> 0.0.1')
end

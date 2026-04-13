# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name     = 'anima'
  s.version  = '0.3.2'

  s.authors  = ['Markus Schirp']
  s.email    = 'mbj@schirp-dso.com'
  s.summary  = 'Initialize object attributes via attributes hash'
  s.homepage = 'https://github.com/mbj/anima'
  s.license  = 'MIT'

  s.files            = Dir.glob('lib/**/*') + Dir.glob('sig/anima/**/*') + Dir.glob('sig/anima.rbs')
  s.require_paths    = %w[lib]
  s.extra_rdoc_files = %w[README.md]

  s.required_ruby_version = '>= 3.3'
  s.required_rubygems_version = '>= 3.3.26'

  s.metadata = {
    'bug_tracker_uri' => "#{s.homepage}/issues",
    'changelog_uri' => "#{s.homepage}/blob/master/Changelog.md",
    'homepage_uri' => s.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => s.homepage
  }

  s.add_dependency('adamantium',    '~> 0.2')
  s.add_dependency('equalizer',     '~> 1.0')
end

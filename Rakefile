# frozen_string_literal: true

require 'bundler/gem_tasks'

# Override release task to skip gem push (handled by GitHub Actions with attestations)
Rake::Task['release'].clear
desc 'Build gem and create tag (gem push handled by CI)'
task release: %w[build release:guard_clean release:source_control_push]

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

desc 'Run mutant mutation testing'
task :mutant do
  system('bundle', 'exec', 'mutant', 'run') or raise 'Mutant task failed'
end

require 'yard'

YARD::Rake::YardocTask.new(:yard)

require 'yardstick/rake/verify'

Yardstick::Rake::Verify.new(:yardstick) do |verify|
  verify.threshold = 100
end

desc 'Run Steep type check'
task :steep do
  system('bundle', 'exec', 'steep', 'check') or raise 'Steep type check failed'
end

task default: %i[spec rubocop mutant yardstick steep]

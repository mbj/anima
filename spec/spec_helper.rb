# encoding: utf-8

require 'anima'
require 'rspec'

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each { |f| require(f) }

if RUBY_VERSION < '1.9'
  require 'rspec/autorun'
end

RSpec.configure do |config|
end

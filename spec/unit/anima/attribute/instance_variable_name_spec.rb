require 'spec_helper'

describe Anima::Attribute, '#instance_variable_name' do
  subject { Anima::Attribute.new(:foo).instance_variable_name }

  it { should be(:@foo) }

  it_should_behave_like 'an idempotent method'
end

require 'spec_helper'

describe Anima::ClassMethods, '#attribute_set' do
  subject { object.attribute_set }

  let(:object) do
    Class.new do
      include Anima
    end
  end

  it { should be_a(Anima::AttributeSet) }

  it_should_behave_like 'an idempotent method' 
end

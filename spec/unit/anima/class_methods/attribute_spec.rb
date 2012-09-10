require 'spec_helper'

describe Anima::ClassMethods, 'attribute' do
  subject { object.attribute(name) }

  let(:name) { :some_method }

  let(:object) do
    Class.new do
      include Anima
    end
  end

  it_should_behave_like 'a command method' 
end

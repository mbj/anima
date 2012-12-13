require 'spec_helper'

describe Anima::Attribute, '#set' do
  let(:object) { described_class.new(:foo) }

  subject { object.set(target, value) }

  let(:target) { Object.new }

  let(:value) { mock('Value') }

  it_should_behave_like 'a command method'

  it 'should set value as instance variable' do
    subject
    target.instance_variable_get(:@foo).should be(value)
  end
end

require 'spec_helper'

describe Anima::Attribute, '#load' do
  let(:object) { described_class.new(:foo) }

  subject { object.load(target, attribute_hash) }

  let(:target) { Object.new }

  let(:value) { mock('Value') }

  context 'when attribute hash contains key' do
    let(:attribute_hash) { { :foo => value } }

    it 'should set value as instance variable' do
      subject
      target.instance_variable_get(:@foo).should be(value)
    end

    it_should_behave_like 'a command method'

  end

  context 'when attribute hash does not contain key' do
    let(:attribute_hash) { {} }

    it 'should raise error' do
      expect { subject }.to raise_error(Anima::Error::Missing, Anima::Error::Missing.new(target.class, :foo).message)
    end
  end
end

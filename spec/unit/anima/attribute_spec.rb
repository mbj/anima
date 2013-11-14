# encoding: utf-8

require 'spec_helper'

describe Anima::Attribute do
  let(:object) { described_class.new(:foo) }

  describe '#get' do
    subject { object.get(target) }

    let(:target_class) do
      Class.new do
        attr_reader :foo

        def initialize(foo)
          @foo = foo
        end
      end
    end

    let(:target) { target_class.new(value) }
    let(:value) { double('Value') }

    it 'should return value' do
      should be(value)
    end
  end

  describe '#load' do
    subject { object.load(target, attribute_hash) }

    let(:target) { Object.new }

    let(:value) { double('Value') }

    context 'when attribute hash contains key' do
      let(:attribute_hash) { { foo: value } }

      it 'should set value as instance variable' do
        subject
        target.instance_variable_get(:@foo).should be(value)
      end

      it_should_behave_like 'a command method'

    end

    context 'when attribute hash does not contain key' do
      let(:attribute_hash) { {} }

      it 'should raise error' do
        expect { subject }.to raise_error(Anima::Error::Missing, Anima::Error::Missing.new(target, :foo).message)
      end
    end
  end

  describe '#set' do
    subject { object.set(target, value) }

    let(:target) { Object.new }

    let(:value) { double('Value') }

    it_should_behave_like 'a command method'

    it 'should set value as instance variable' do
      subject
      target.instance_variable_get(:@foo).should be(value)
    end
  end
end

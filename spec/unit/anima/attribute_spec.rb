require 'spec_helper'

describe Anima::Attribute do
  let(:object) { described_class.new(:foo) }

  describe '#define_reader' do
    subject { object.define_reader(target_class) }

    let(:target_class) do
      Class.new do
        def initialize(foo)
          @foo = foo
        end
      end
    end

    let(:value) { double('Value') }

    it 'should create a reader' do
      instance = target_class.new(value)
      lambda { subject }.should change { instance.respond_to?(:foo) }.from(false).to(true)
    end

    it_should_behave_like 'a command method'
  end

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

  describe '#instance_variable_name' do
    subject { Anima::Attribute.new(:foo).instance_variable_name }

    it { should be(:@foo) }

    it_should_behave_like 'an idempotent method'
  end

  describe '#load' do
    subject { object.load(target, attribute_hash) }

    let(:target) { Object.new }

    let(:value) { double('Value') }

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

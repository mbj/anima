require 'spec_helper'

describe Anima do
  let(:object) { described_class.new(:foo) }

  describe '#attributes_hash' do
    let(:value)    { double('Value')    }
    let(:instance) { double(foo: value) }

    subject { object.attributes_hash(instance) }

    it { should eql(foo: value) }
  end

  describe '#remove' do
    let(:object)  { described_class.new(:foo, :bar) }

    context 'with single attribute' do
      subject { object.remove(:bar) }

      it { should eql(described_class.new(:foo)) }
    end

    context 'with multiple attributes' do
      subject { object.remove(:foo, :bar) }

      it { should eql(described_class.new) }
    end

    context 'with inexisting attribute' do
      subject { object.remove(:baz) }

      it { should eql(object) }
    end
  end

  describe '#add' do
    context 'with single attribute' do
      subject { object.add(:bar) }

      it { should eql(described_class.new(:foo, :bar)) }
    end

    context 'with multiple attributes' do
      subject { object.add(:bar, :baz) }

      it { should eql(described_class.new(:foo, :bar, :baz)) }
    end

    context 'with duplicate attribute ' do
      subject { object.add(:foo) }

      it { should eql(object) }
    end
  end

  describe '#attributes' do
    subject { object.attributes }

    it { should eql([Anima::Attribute.new(:foo)]) }
    it { should be_frozen                         }
  end

  describe '#included' do
    let(:target) do
      object = self.object
      Class.new do
        include object
      end
    end

    let(:value)      { double('Value')                }
    let(:instance)   { target.new(foo: value)         }
    let(:instance_b) { target.new(foo: value)         }
    let(:instance_c) { target.new(foo: double('Bar')) }

    context 'on instance' do
      subject { instance }

      its(:foo) { should be(value) }

      it { should eql(instance_b) }
    end

    context 'on singleton' do
      subject { target }

      it 'should define attribute hash reader' do
        target.attributes_hash(instance).should eql(foo: value)
      end

      its(:anima) { should be(object) }
    end
  end

  describe '#initialize_instance' do
    let(:object) { Anima.new(:foo, :bar) }
    let(:target) { Object.new }
    let(:foo) { double('Foo') }
    let(:bar) { double('Bar') }

    subject { object.initialize_instance(target, attribute_hash) }

    context 'when all keys are present in attribute hash' do
      let(:attribute_hash) { { foo: foo, bar: bar } }

      it 'should initialize target instance variables' do
        subject
        target.instance_variables.map(&:to_sym).to_set.should eql([:@foo, :@bar].to_set)
        target.instance_variable_get(:@foo).should be(foo)
        target.instance_variable_get(:@bar).should be(bar)
      end

      it_should_behave_like 'a command method'
    end

    context 'when extra key is missing in attribute hash' do
      let(:attribute_hash) { { foo: foo, bar: bar, baz: double('Baz') } }

      it 'should raise error' do
        expect { subject }.to raise_error(Anima::Error::Unknown, Anima::Error::Unknown.new(target.class, [:baz]).message)
      end
    end

    context 'when a key is missing in attribute hash' do
      let(:attribute_hash) { { bar: bar } }

      it 'should raise error' do
        expect { subject }.to raise_error(Anima::Error::Missing, Anima::Error::Missing.new(target.class, :foo).message)
      end
    end
  end
end

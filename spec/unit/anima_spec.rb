# frozen_string_literal: true

RSpec.describe Anima do
  let(:object) { described_class.new(:foo) }

  describe '#attributes_hash' do
    subject(:result) { object.attributes_hash(instance) }

    let(:value) { Object.new }
    let(:instance) { Struct.new(:foo).new(value) }

    it { is_expected.to eql(foo: value) }
  end

  describe '#remove' do
    let(:object) { described_class.new(:foo, :bar) }

    context 'with single attribute' do
      subject { object.remove(:bar) }

      it { is_expected.to eql(described_class.new(:foo)) }
    end

    context 'with multiple attributes' do
      subject { object.remove(:foo, :bar) }

      it { is_expected.to eql(described_class.new) }
    end

    context 'with inexisting attribute' do
      subject { object.remove(:baz) }

      it { is_expected.to eql(object) }
    end
  end

  describe '#add' do
    context 'with single attribute' do
      subject { object.add(:bar) }

      it { is_expected.to eql(described_class.new(:foo, :bar)) }
    end

    context 'with multiple attributes' do
      subject { object.add(:bar, :baz) }

      it { is_expected.to eql(described_class.new(:foo, :bar, :baz)) }
    end

    context 'with duplicate attribute' do
      subject { object.add(:foo) }

      it { is_expected.to eql(object) }
    end
  end

  describe '#attributes' do
    subject { object.attributes }

    it { is_expected.to eql([Anima::Attribute.new(:foo)]) }
    it { is_expected.to be_frozen                         }
  end

  describe '#included' do
    let(:target) do
      object = self.object
      Class.new do
        include object
      end
    end

    let(:value) { Object.new }

    context 'with instance' do
      subject(:instance) { target.new(foo: value) }

      let(:instance_b) { target.new(foo: value) }
      let(:instance_c) { target.new(foo: Object.new) }

      it { expect(instance.foo).to be(value) }
      it { is_expected.to eql(instance_b) }
      it { is_expected.not_to eql(instance_c) }
    end

    context 'with singleton' do
      subject(:singleton) { target }

      it 'defines attribute hash reader' do
        instance = target.new(foo: value)
        expect(instance.to_h).to eql(foo: value)
      end

      it { expect(singleton.anima).to be(object) }
    end
  end

  describe '#initialize_instance' do
    subject(:result) { object.initialize_instance(target, attribute_hash) }

    let(:object) { described_class.new(:foo, :bar) }
    let(:target) { Object.new }
    let(:foo) { Object.new }
    let(:bar) { Object.new }

    context 'when all keys are present in attribute hash' do
      let(:attribute_hash) { { foo: foo, bar: bar } }

      it 'sets foo instance variable' do
        result
        expect(target.instance_variable_get(:@foo)).to be(foo)
      end

      it 'sets bar instance variable' do
        result
        expect(target.instance_variable_get(:@bar)).to be(bar)
      end

      it 'sets exactly the expected instance variables' do
        result
        expect(target.instance_variables.to_set(&:to_sym)).to eql(%i[@foo @bar].to_set)
      end

      it_behaves_like 'a command method'
    end

    context 'when an extra key is present in attribute hash' do
      let(:attribute_hash) { { foo: foo, bar: bar, baz: Object.new } }

      it 'raises error' do
        expect { result }.to raise_error(
          Anima::Error,
          Anima::Error.new(target.class, [], [:baz]).message
        )
      end
    end

    context 'when an extra falsy key is present in attribute hash' do
      let(:attribute_hash) { { foo: foo, bar: bar, nil => Object.new } }

      it 'raises error' do
        expect { result }.to raise_error(
          Anima::Error,
          Anima::Error.new(target.class, [], [nil]).message
        )
      end
    end

    context 'when a key is missing in attribute hash' do
      let(:attribute_hash) { { bar: bar } }

      it 'raises error' do
        expect { result }.to raise_error(
          Anima::Error.new(target.class, [:foo], []).message
        )
      end
    end
  end

  describe 'using super in initialize' do
    subject(:instance) { klass.new }

    let(:klass) do
      Class.new do
        include Anima.new(:foo)

        def initialize(attributes = { foo: :bar })
          super
        end
      end
    end

    it { expect(instance.foo).to be(:bar) }
  end

  describe '#to_h' do
    subject { instance.to_h }

    let(:instance) { klass.new(params) }
    let(:params)   { { foo: :bar } }
    let(:klass) do
      Class.new do
        include Anima.new(:foo)
      end
    end

    it { is_expected.to eql(params) }
  end

  describe '#with' do
    subject { object.with(attributes) }

    let(:klass) do
      Class.new do
        include Anima.new(:foo, :bar)
      end
    end

    let(:object) { klass.new(foo: 1, bar: 2) }

    context 'with empty attributes' do
      let(:attributes) { {} }

      it { is_expected.to eql(object) }
    end

    context 'with updated attribute' do
      let(:attributes) { { foo: 3 } }

      it { is_expected.to eql(klass.new(foo: 3, bar: 2)) }
    end
  end
end

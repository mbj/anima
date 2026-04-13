# frozen_string_literal: true

RSpec.describe Anima::Attribute do
  let(:object) { described_class.new(:foo) }

  describe '#get' do
    subject(:result) { object.get(target) }

    let(:target_class) do
      Class.new do
        attr_reader :foo

        def initialize(foo)
          @foo = foo
        end
      end
    end

    let(:target) { target_class.new(value) }
    let(:value) { Object.new }

    it 'returns value' do
      expect(result).to be(value)
    end
  end

  describe '#load' do
    subject(:result) { object.load(target, attribute_hash) }

    let(:target)         { Object.new     }
    let(:value)          { Object.new     }
    let(:attribute_hash) { { foo: value } }

    it 'sets value as instance variable' do
      result
      expect(target.instance_variable_get(:@foo)).to be(value)
    end

    it_behaves_like 'a command method'
  end

  describe '#instance_variable_name' do
    subject(:result) { object.instance_variable_name }

    it { is_expected.to be(:@foo) }

    it_behaves_like 'an idempotent method'
  end

  describe '#set' do
    subject(:result) { object.set(target, value) }

    let(:target) { Object.new }
    let(:value) { Object.new }

    it_behaves_like 'a command method'

    it 'sets value as instance variable' do
      result
      expect(target.instance_variable_get(:@foo)).to be(value)
    end
  end
end

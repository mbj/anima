require 'spec_helper'

describe Anima::Attribute, '#get' do
  let(:object) { described_class.new(:foo) }

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

  let(:value) { mock('Value') }

  it 'should return value' do
    should be(value)
  end
end

require 'spec_helper'

describe Anima::Attribute, '#define_reader' do
  let(:object) { described_class.new(:foo) }

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

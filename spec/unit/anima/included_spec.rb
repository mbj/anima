require 'spec_helper'

describe Anima, '#included' do
  let(:object) { described_class.new(:foo) }

  let(:target) do
    object = self.object
    Class.new do
      include object
    end
  end

  let(:value) { double('Value') }

  let(:instance)   { target.new(:foo => value) }
  let(:instance_b) { target.new(:foo => value) }
  let(:instance_c) { target.new(:foo => double('Bar')) }

  context 'on instance' do
    subject { instance }

    its(:foo) { should be(value) }

    it { should eql(instance_b) }
  end

  context 'on singleton' do
    subject { target }

    it 'should define attribute hash reader' do
      target.attributes_hash(instance).should eql(:foo => value)
    end

    its(:anima) { should be(object) }
  end
end

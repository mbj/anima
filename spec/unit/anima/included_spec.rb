require 'spec_helper'

describe Anima, '#included' do
  let(:target) do
    Class.new do
      include Anima.new(:foo)
    end
  end

  let(:value) { mock('Value') }

  let(:instance_b) { target.new(:foo => value) }
  let(:instance_c) { target.new(:foo => mock('Bar')) }

  subject { target.new(:foo => value) }

  its(:foo) { should be(value) }

  it { should eql(instance_b) }

  it 'should define attribute hash reader' do
    target.attribute_hash(subject).should eql(:foo => value)
  end
end

require 'spec_helper'

describe Anima, '#attributes_hash' do
  let(:object) { described_class.new(:foo) }

  let(:value) { mock('Value') }

  let(:instance) { mock(:foo => value) }

  subject { object.attributes_hash(instance) }

  it { should eql(:foo => value) }
end

require 'spec_helper'

describe Anima, '#attributes' do
  subject { object.attributes }

  let(:object) { described_class.new(:foo) }

  it { should eql([Anima::Attribute.new(:foo)]) }
  it { should be_frozen                         }
end

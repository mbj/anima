require 'spec_helper'

describe Anima, 'set attribute' do
  subject { class_under_test.new(attributes) }

  let(:class_under_test) do
    Class.new do
      include Anima

      attribute :stuff, Anima::Attribute::Set
    end
  end

  context 'when instanciated with expcicit attributes' do
    let(:attributes) { { :stuff => :bar } }

    its(:stuff) { should be(:bar) }
  end

  context 'when instanciated without expicit attribute' do
    let(:attributes) { { } } 

    its(:stuff) { should eql(Set.new) }
  end
end

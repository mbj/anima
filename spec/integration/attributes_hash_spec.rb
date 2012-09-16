require 'spec_helper'

describe Anima, 'attributes hash' do

  subject { class_under_test.new(attributes) }

  let(:class_under_test) do
    Class.new do
      include Anima

      def self.name
        'TestClass'
      end

      attribute :firstname
      attribute :lastname
    end
  end

  let(:attributes) do
    {
      :firstname => 'Markus',
      :lastname => 'Schirp'
    }
  end

  let(:object) { class_under_test.new(attributes) }

  specify 'allows to access attributes' do
    object.attributes.should eql(attributes)
  end
end

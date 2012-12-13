require 'spec_helper'

describe Anima, 'attributes hash' do

  subject { class_under_test.new(attributes) }

  let(:class_under_test) do
    Class.new do
      include Anima.new(:firstname, :lastname)

      def self.name
        'TestClass'
      end
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
    class_under_test.attribute_hash(object).should eql(attributes)
  end
end

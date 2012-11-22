require 'spec_helper'

describe Anima, 'simple integration' do
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

  context 'when instanciated with all attributes' do
    let(:attributes) do
      {
        :firstname => 'Markus',
        :lastname => 'Schirp'
      }
    end

    its(:firstname) { should eql('Markus') }
    its(:lastname) { should eql('Schirp') }
  end

  context 'with instanciated with extra attributes' do
    let(:attributes) do 
      {
        :firstname => 'Markus',
        :lastname => 'Schirp',
        :extra => 'Foo'
      }
    end

    it 'should raise error' do
      expect { subject }.to raise_error(
        Anima::AttributeError::Unknown, 
        'Unknown attribute(s) [:extra] for TestClass'
      )
    end
  end

  context 'when instanciated with missing attribute' do

    let(:attributes) { {} }

    it 'should raise error' do
      expect { subject }.to raise_error(
        Anima::AttributeError::Missing,
        'Missing attribute(s) :firstname for TestClass'
      )
    end
  end
end

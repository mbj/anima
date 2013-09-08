require 'spec_helper'

describe Anima, 'simple integration' do
  subject { class_under_test.new(attributes) }

  let(:class_under_test) do
    Class.new do
      include Anima.new(:firstname, :lastname)

      def self.name
        'TestClass'
      end
    end
  end

  context 'when instanciated with all attributes' do
    let(:attributes) do
      {
        firstname: 'Markus',
        lastname:  'Schirp'
      }
    end

    its(:firstname) { should eql('Markus') }
    its(:lastname) { should eql('Schirp') }
  end

  context 'with instanciated with extra attributes' do
    let(:attributes) do
      {
        firstname: 'Markus',
        lastname:  'Schirp',
        extra:     'Foo'
      }
    end

    it 'should raise error' do
      expect { subject }.to raise_error(
        Anima::Error::Unknown,
        'Unknown attribute(s) [:extra] for TestClass'
      )
    end
  end

  context 'when instanciated with missing attribute' do

    let(:attributes) { {} }

    it 'should raise error' do
      expect { subject }.to raise_error(
        Anima::Error::Missing,
        'Missing attribute(s) :firstname for TestClass'
      )
    end
  end
end

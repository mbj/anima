require 'spec_helper'

describe Anima, 'inherited attributes' do
  subject { class_under_test.new(attributes) }

  let(:base_class) do
    Class.new do
      include Anima
      attribute :title
    end
  end

  let(:class_under_test) do
    Class.new(base_class) do
      attribute :firstname
      attribute :lastname

      def self.name
        'TestClass'
      end
    end
  end

  context 'when instanciated with all attributes' do
    let(:attributes) do
      {
        :title     => 'Mr',
        :firstname => 'Markus',
        :lastname  => 'Schirp'
      }
    end

    its(:firstname) { should eql('Markus') }
    its(:lastname)  { should eql('Schirp') }
  end

  context 'with instanciated with extra attributes' do
    let(:attributes) do 
      {
        :title     => 'Mr',
        :firstname => 'Markus',
        :lastname  => 'Schirp',
        :extra     => 'Something'
      }
    end

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError,'Unknown attribute(s) [:extra] given when initializing TestClass')
    end
  end

  context 'when instanciated with missing attribute' do

    let(:attributes) { {} }

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError,'No value given for :title when initializing TestClass')
    end
  end
end

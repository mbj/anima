# encoding: utf-8

require 'spec_helper'

class TestClass
  include Anima.new(:firstname, :lastname)
end

describe Anima, 'simple integration' do
  subject { TestClass.new(attributes) }

  context 'when instantiated with all attributes' do
    let(:attributes) do
      {
        firstname: 'Markus',
        lastname:  'Schirp'
      }
    end

    its(:firstname) { should eql('Markus') }
    its(:lastname) { should eql('Schirp') }
  end

  context 'with instantiated with extra attributes' do
    let(:attributes) do
      {
        firstname: 'Markus',
        lastname:  'Schirp',
        extra:     'Foo'
      }
    end

    it 'should raise error' do
      expect { subject }.to raise_error(
        Anima::Error,
        'TestClass attributes missing: [], unknown: [:extra]'
      )
    end
  end

  context 'when instantiated with missing attributes' do
    let(:attributes) { {} }

    it 'should raise error' do
      expect { subject }.to raise_error(
        Anima::Error,
        'TestClass attributes missing: [:firstname, :lastname], unknown: []'
      )
    end
  end
end

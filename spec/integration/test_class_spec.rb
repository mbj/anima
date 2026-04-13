# frozen_string_literal: true

class TestClass
  include Anima.new(:firstname, :lastname)
end

RSpec.describe TestClass do
  subject(:person) { described_class.new(attributes) }

  context 'when instantiated with all attributes' do
    let(:attributes) do
      {
        firstname: 'Markus',
        lastname: 'Schirp'
      }
    end

    it { expect(person.firstname).to eql('Markus') }
    it { expect(person.lastname).to eql('Schirp') }
  end

  context 'with extra attributes' do
    let(:attributes) do
      {
        firstname: 'Markus',
        lastname: 'Schirp',
        extra: 'Foo'
      }
    end

    it 'raises error' do
      expect { person }.to raise_error(
        Anima::Error,
        'TestClass attributes missing: [], unknown: [:extra]'
      )
    end
  end

  context 'when instantiated with missing attributes' do
    let(:attributes) { {} }

    it 'raises error' do
      expect { person }.to raise_error(
        Anima::Error,
        'TestClass attributes missing: [:firstname, :lastname], unknown: []'
      )
    end
  end
end

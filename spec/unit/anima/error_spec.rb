# frozen_string_literal: true

RSpec.describe Anima::Error do
  describe '#message' do
    subject(:result) { object.message }

    let(:object) { described_class.new(Anima, missing, unknown) }

    let(:missing) { %i[missing] }
    let(:unknown) { %i[unknown] }

    it 'returns the message string' do
      expect(result).to eql('Anima attributes missing: [:missing], unknown: [:unknown]')
    end

    it_behaves_like 'an idempotent method'
  end
end

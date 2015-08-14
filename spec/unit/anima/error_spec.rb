# encoding: utf-8

require 'spec_helper'

describe Anima::Error do
  describe '#message' do
    let(:object) { described_class.new(Anima, missing, unknown) }

    let(:missing) { %i[missing] }
    let(:unknown) { %i[unknown] }

    subject { object.message }

    it 'should return the message string' do
      should eql('Anima attributes missing: [:missing], unknown: [:unknown]')
    end

    it_should_behave_like 'an idempotent method'
  end
end

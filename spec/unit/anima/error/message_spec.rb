require 'spec_helper'

describe Anima::Error, '#message' do
  let(:object) { described_class.new(klass, name) }

  subject { object.message }

  let(:klass) { double(:name => 'THE-CLASS-NAME') }
  let(:name)  { 'THE-ATTRIBUTE-NAME' }

  it 'should return the message string' do
    should eql('Error attribute(s) "THE-ATTRIBUTE-NAME" for THE-CLASS-NAME')
  end

  it_should_behave_like 'an idempotent method'
end

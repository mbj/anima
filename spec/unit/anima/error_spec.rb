require 'spec_helper'

describe Anima::Error, '#message' do
  let(:object) { error.new(klass, name) }

  let(:error) do
    Class.new(described_class) do
      def self.name
        'TestError'
      end
    end
  end

  subject { object.message }

  let(:klass) { double(name: 'THE-CLASS-NAME') }
  let(:name)  { 'THE-ATTRIBUTE-NAME' }

  it 'should return the message string' do
    should eql('TestError attribute(s) "THE-ATTRIBUTE-NAME" for THE-CLASS-NAME')
  end

  it_should_behave_like 'an idempotent method'
end

require 'spec_helper'

describe Anima, 'simple integration' do
  subject { class_under_test.new(attributes) }

  let(:code_attribute) do
    Class.new(Anima::Attribute) do
      def default
        Anima::Default::Generator.new { |object| :foo }
      end
    end
  end

  let(:class_under_test) do
    code_attribute = self.code_attribute
    Class.new do
      include Anima

      attribute :code, code_attribute
    end
  end

  context 'when instanciated with expcicit attributes' do
    let(:attributes) { { :code => :bar } }

    its(:code) { should be(:bar) }
  end

  context 'when instanciated with out expicit attribute' do
    let(:attributes) { { } } 

    its(:code) { should be(:foo) }
  end
end

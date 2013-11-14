# encoding: utf-8

require 'spec_helper'

describe Anima::Update, '#update' do
  subject { object.update(attributes) }

  let(:object) { class_under_test.new(foo: 1, bar: 2) }

  let(:class_under_test) do
    Class.new do
      include Anima.new(:foo, :bar), Anima::Update
    end
  end

  context 'with empty attributes' do
    let(:attributes) { {} }

    it { should eql(object) }
  end

  context 'with updated attribute' do
    let(:attributes) { { foo: 3 } }

    it { should eql(class_under_test.new(foo: 3, bar: 2)) }
  end
end

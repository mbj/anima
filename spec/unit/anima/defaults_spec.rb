# encoding: utf-8

require 'spec_helper'

describe Anima::Defaults do
  subject do
    Class.new do
      include Anima.new(:foo, :bar), Anima::Defaults.new(foo: 1, bar: 2)
    end
  end

  its(:anima_defaults) { should eql(foo: 1, bar: 2) }

  it 'should merge the defaults' do
    expect(subject.new(foo: 1).bar).to equal 2
  end
end

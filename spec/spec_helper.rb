# frozen_string_literal: true

require 'anima'

RSpec.shared_examples 'a command method' do
  it 'returns self' do
    expect(result).to be(object)
  end
end

RSpec.shared_examples 'an idempotent method' do
  it 'returns the same value on subsequent calls' do
    first = result
    expect(result).to be(first)
  end
end

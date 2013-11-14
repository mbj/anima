# encoding: utf-8

class Anima
  # Module for mixin in update functionallity to anima infected clases
  module Update

    # Return updated instance
    #
    # @example
    #   klass = Class.new do
    #     include Anima.new(:foo, :bar), Anima::Update
    #   end
    #
    #   foo = klass.new(:foo => 1, :bar => 2)
    #   updated = foo.update(:foo => 3)
    #   updated.foo # => 3
    #   updated.bar # => 2
    #
    # @param [Hash] attributes
    #
    # @return [Anima]
    #
    # @api private
    #
    def update(attributes)
      self.class.new(to_h.update(attributes))
    end

  end # Update
end # Anima

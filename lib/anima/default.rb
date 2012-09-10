module Anima

  # Abstract class for attribute default
  class Default
    include AbstractClass, Immutable

    abstract_method :set

    # No default value
    NONE = Class.new(self) do

      # Set default value
      #
      # @param [Attribute] attribute
      # @param [Object] object
      #
      # @return [undefined]
      #
      # @raise RuntimeError
      #   raises runtime error about missing default
      #
      # @api private
      #
      def set(attribute, object)
        raise "No value given for #{attribute.name.inspect} when initializing #{object.class.name}"
      end

    end.new

    # Explicit default value
    class Value < self

      # Initialize default value
      #
      # @param [Object] value
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(value)
        @value = value
      end

      # Set default value
      #
      # @param [Attribute] attribute
      # @param [Object] object
      #
      # @return [self]
      #
      # @api private
      #
      def set(attribute, object)
        attribute.set(object, @value)
      end

    end

    NIL = Value.new(nil)
  end
end

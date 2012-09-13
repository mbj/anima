module Anima

  # Abstract class for attribute default
  class Default
    include AbstractClass, Immutable

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
      attribute.set(object, value(object))
    end

    # Return default value for object
    #
    # @param [Object] object
    #
    # @return [Object]
    #
    # @api private
    #
    abstract_method :value


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

    # Generated default value
    class Generator < self

    private

      # Initialize object
      #
      # @api private
      #
      # @return [undefined]
      #
      def initialize(&block)
        @block = block
      end

      # Return generated value
      #
      # @return [Object]
      #
      # @api private
      #
      def value(object)
        @block.call(object)
      end
    end

    # Explicit default value
    class Value < self

    private

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

      # Return default value
      #
      # @param [Object] object
      #
      # @return [Object]
      #
      # @api private
      #
      def value(object)
        @value
      end
    end

    NIL = Value.new(nil)
  end
end

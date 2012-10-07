module Anima

  # Set of attributes
  class AttributeSet 
    include Enumerable

    # Load attributes into instance
    #
    # @param [Object] object
    #
    # @param [Hash] attributes
    #
    # @return [self]
    #
    # @api private
    #
    def load(object, attributes)
      visited = []
      each do |attribute|
        attribute.load(object, attributes)
        visited << attribute.name
      end

      overflow = attributes.keys - visited

      unless overflow.empty?
        raise AttributeError::Unknown.new(object.class, overflow)
      end

      self
    end

    # Enumerate attributes
    #
    # @return [Enumerator<Attribute>] 
    #   returns attribute enumerator if block not given
    #
    # @return [self]
    #   returns self otherwise
    #
    # @yieldparam attribute [Attribute]
    #
    def each
      return to_enum unless block_given?

      @index.each_value do |attribute|
        yield attribute
      end

      self
    end

    # Add attribute to set
    #
    # @param [Attribute]
    #
    # @return [self]
    #
    # @api private
    #
    def add(attribute)
      @index[attribute.name] = attribute

      self
    end

    # Get attribute
    #
    # @param [Symbol]
    #
    # @return [Attribute]
    #
    # @api private
    #
    def get(name)
      @index.fetch(name)
    end

  private

    # Initialize object
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize
      @index = {}
    end
  end
end

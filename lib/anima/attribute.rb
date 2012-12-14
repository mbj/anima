class Anima

  # An attribute
  class Attribute
    include Adamantium::Flat, Equalizer.new(:name)

    # Return attribute name
    #
    # @return [Symbol]
    #
    # @api private
    #
    attr_reader :name
    
    # Load attribute
    #
    # @param [Object] object
    # @param [Hash] attributes
    #
    # @return [self]
    #
    # @api private
    #
    def load(object, attributes)
      attribute_name = name

      value = attributes.fetch(attribute_name) do 
        raise Error::Missing.new(object.class, attribute_name)
      end

      set(object, value)
    end

    # Get attribute value from object
    #
    # @param [Object] object
    #
    # @return [Object] 
    #
    # @api private
    #
    def get(object)
      object.public_send(name)
    end

    # Set attribute value in object
    #
    # @param [Object] object
    # @param [Object] value
    #
    # @return [self]
    #
    # @api private
    #
    def set(object, value)
      object.instance_variable_set(instance_variable_name, value)

      self
    end

    # Return instance variable name
    #
    # @return [Symbol]
    #   returns @ prefixed name
    #
    # @api private
    #
    def instance_variable_name
      :"@#{name}"
    end
    memoize :instance_variable_name

    # Define reader
    #
    # @param [Class, Module] scope
    #
    # @return [self]
    #
    # @api private
    #
    def define_reader(scope)
      scope.send(:attr_reader, name)
      self
    end

  private


    # Initialize attribute
    #
    # @param [Symbol] name
    #
    # @api private
    #
    def initialize(name)
      @name = name
    end
  end
end

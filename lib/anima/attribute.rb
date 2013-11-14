# encoding: utf-8

class Anima

  # An attribute
  class Attribute
    include Adamantium::Flat, Equalizer.new(:name)

    # Initialize attribute
    #
    # @param [Symbol] name
    #
    # @api private
    #
    def initialize(name)
      @name, @instance_variable_name = name, :"@#{name}"
    end

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
      value = attributes.fetch(name) do |attribute_name|
        fail Error::Missing.new(object, attribute_name)
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
      object.instance_variable_set(@instance_variable_name, value)

      self
    end

  end # Attribute
end # Anima

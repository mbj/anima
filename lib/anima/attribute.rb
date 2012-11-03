module Anima

  # Attribute metadata 
  class Attribute
    include Adamantium::Flat

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
      value = attributes.fetch(name) do
        default.set(self, object)
        return
      end

      set(object, value)

      self
    end

    # Get attribte value from object
    #
    # @param [Object] object
    #
    # @return [Object] 
    #
    def get(object)
      object.instance_variable_get(instance_variable_name)
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

    # Define reader method on scope
    #
    # @param [Class|Module] scope
    #
    # @return [self]
    #
    # @api private
    #
    def define_reader(scope)
      name = self.name
      instance_variable_name = self.instance_variable_name

      scope.class_eval do
        define_method(name) do
          instance_variable_get(instance_variable_name)
        end
      end

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

    # Return default value
    #
    # @return [Default]
    #
    # @api private
    #
    attr_reader :default

  private

    DEFAULT = Default::NONE

    # Return default
    #
    # @return [Default]
    # 
    # @api private
    #
    def self.default
      self::DEFAULT
    end

    # Initialize attribute
    #
    # @param [Symbol] name
    # @param [Default] default
    #
    # @api private
    #
    def initialize(name, default = Undefined)
      @name = name
      @default = default == Undefined ? self.class.default : default
    end
  end
end

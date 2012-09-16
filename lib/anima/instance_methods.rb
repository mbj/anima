module Anima

  # Instance level resource methods
  module InstanceMethods

    # Return attributes
    #
    # @return [Hash]
    #
    # @api private
    #
    def attributes
      attribute_set.each_with_object({}) do |attribute, attributes|
        attributes[attribute.name] = attribute.get(self)
      end
    end

  private

    # Initialize resource
    #
    # @param [Hash] attributes
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(attributes = {})
      attribute_set.load(self, attributes)
    end

    # Return attribute set
    #
    # @return [AttributeSet]
    #
    # @api private
    #
    def attribute_set
      self.class.attribute_set
    end
  end
end

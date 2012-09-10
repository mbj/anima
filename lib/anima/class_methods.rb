# Main library namespace and mixin
module Anima

  # Class level resource methods
  module ClassMethods 

    # Return attribute set
    #
    # @return [AttributeSet]
    #
    # @api private
    #
    def attribute_set
      @attribute_set ||= AttributeSet.new
    end

    # Create attribute
    #
    # @param [Symbol] name
    #
    # @return [self]
    #
    def attribute(name)
      attribute = Attribute.new(name)
      attribute.define_reader(self)
      attribute_set.add(attribute)

      self
    end
  end
end

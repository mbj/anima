module Anima

  # Instance level resource methods
  module InstanceMethods

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

  private

    def attribute_set
      self.class.attribute_set
    end
  end
end

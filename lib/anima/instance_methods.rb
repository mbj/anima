module Anima

  # Instance level resource methods
  module InstanceMethods

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
      self.class.attribute_set.load(self, attributes)
    end
  end
end

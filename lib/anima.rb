require 'adamantium'
require 'equalizer'
require 'abstract_class'

# Main library namespace and mixin
module Anima

  # Abstract base class for attribute errors
  class AttributeError < RuntimeError
    include AbstractClass

    # Initialize object
    #
    # @param [Class] model
    # @param [Enumerable<Symbol>] names
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(model, names)
      super("#{self.class.name.split('::').last} attribute(s) #{names.inspect} for #{model.name}")
    end

    # Error for unknown attributes
    class Unknown < self
    end

    # Error for missing attributes
    class Missing < self
    end

  end

  # Error raised when

  # Undefined object (maybe used for some params)
  Undefined = Object.new.freeze

  # Hook called when module is included
  #
  # @param [Class|Module] descendant
  #
  # @api private
  #
  def self.included(descendant)
    super

    descendant.class_eval do
      include InstanceMethods
      extend ClassMethods
    end
  end
end

require 'anima/default'
require 'anima/attribute'
require 'anima/attribute_set'
require 'anima/class_methods'
require 'anima/instance_methods'

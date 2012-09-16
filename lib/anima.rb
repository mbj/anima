require 'immutable'
require 'abstract_class'

# Main library namespace and mixin
module Anima

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

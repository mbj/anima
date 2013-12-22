# encoding: utf-8

require 'adamantium'
require 'equalizer'
require 'abstract_type'

# Main library namespace and mixin
class Anima < Module
  include Adamantium::Flat, Equalizer.new(:attributes)

  # Return names
  #
  # @return [AttributeSet]
  #
  # @api private
  #
  attr_reader :attributes

  # Initialize object
  #
  # @return [undefined]
  #
  # @api private
  #
  def initialize(*names)
    @attributes = names.uniq.map(&Attribute.method(:new)).freeze
  end

  # Return new anima with attributes added
  #
  # @return [Anima]
  #
  # @example
  #   anima = Anima.new(:foo, :bar)
  #   anima.add(:foo) # equals Anima.new(:foo, :bar)
  #
  # @api private
  #
  def add(*names)
    new(attribute_names + names)
  end

  # Return new anima with attributes removed
  #
  # @return [Anima]
  #
  # @example
  #   anima = Anima.new(:foo)
  #   anima.remove(:bar) # equals Anima.new(:foo)
  #
  # @api public
  #
  def remove(*names)
    new(attribute_names - names)
  end

  # Return attributes hash for instance
  #
  # @param [Object] object
  #
  # @return [Hash]
  #
  # @api private
  #
  def attributes_hash(object)
    attributes.each_with_object({}) do |attribute, attributes_hash|
      attributes_hash[attribute.name] = attribute.get(object)
    end
  end

  # Return attribute names
  #
  # @return [Enumerable<Symbol>]
  #
  # @api private
  #
  def attribute_names
    attributes.map(&:name)
  end
  memoize :attribute_names

  # Initialize instance
  #
  # @param [Object] object
  #
  # @param [Hash] attribute_hash
  #
  # @return [self]
  #
  # @api private
  #
  def initialize_instance(object, attribute_hash)
    assert_known_attributes(object, attribute_hash)
    attributes.each do |attribute|
      attribute.load(object, attribute_hash)
    end
    self
  end

  private

  # Hook called when module is included
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def included(descendant)
    Builder.call(self, descendant)
  end

  # Fail unless keys in +attribute_hash+ matches #attribute_names
  #
  # @param [Object] object
  #   the object being initialized
  #
  # @param [Hash] attribute_hash
  #   the attributes to initialize +object+ with
  #
  # @return [undefined]
  #
  # @raise [Error::Unknown]
  #
  # @api private
  def assert_known_attributes(object, attribute_hash)
    overflow = attribute_hash.keys - attribute_names

    if overflow.any?
      fail Error::Unknown.new(object, overflow)
    end
  end

  # Return new instance
  #
  # @param [Enumerable<Symbol>] attributes
  #
  # @return [Anima]
  #
  # @api private
  #
  def new(attributes)
    self.class.new(*attributes)
  end

end # Anima

require 'anima/builder'
require 'anima/error'
require 'anima/attribute'
require 'anima/update'

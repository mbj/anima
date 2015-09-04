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
  #   anima = Anima.new(:foo)
  #   anima.add(:bar) # equals Anima.new(:foo, :bar)
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
  #   anima = Anima.new(:foo, :bar)
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
    assert_known_attributes(object.class, attribute_hash)
    attributes.each do |attribute|
      attribute.load(object, attribute_hash)
    end
    self
  end

  # Static instance methods for anima infected classes
  module InstanceMethods
    # Initialize an anima infected object
    #
    # @param [#to_h] attributes
    #   a hash that matches anima defined attributes
    #
    # @return [undefined]
    #
    # @api public
    def initialize(attributes)
      self.class.anima.initialize_instance(self, attributes)
    end

    # Return a hash representation of an anima infected object
    #
    # @return [Hash]
    #
    # @api public
    def to_h
      self.class.anima.attributes_hash(self)
    end

    # Return updated instance
    #
    # @example
    #   klass = Class.new do
    #     include Anima.new(:foo, :bar)
    #   end
    #
    #   foo = klass.new(:foo => 1, :bar => 2)
    #   updated = foo.with(:foo => 3)
    #   updated.foo # => 3
    #   updated.bar # => 2
    #
    # @param [Hash] attributes
    #
    # @return [Anima]
    #
    # @api private
    #
    def with(attributes)
      self.class.new(to_h.update(attributes))
    end
  end # InstanceMethods

  private

  # Infect the instance with anima
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def included(descendant)
    descendant.instance_exec(self, attribute_names) do |anima, names|
      # Define anima method
      define_singleton_method(:anima) { anima }

      # Define instance methods
      include InstanceMethods

      # Define attribute readers
      attr_reader(*names)

      # Define equalizer
      include Equalizer.new(*names)
    end
  end

  # Fail unless keys in +attribute_hash+ matches #attribute_names
  #
  # @param [Class] klass
  #   the class being initialized
  #
  # @param [Hash] attribute_hash
  #   the attributes to initialize +object+ with
  #
  # @return [undefined]
  #
  # @raise [Error]
  #
  # @api private
  def assert_known_attributes(klass, attribute_hash)
    keys = attribute_hash.keys

    unknown = keys - attribute_names
    missing = attribute_names - keys

    fail Error.new(klass, missing, unknown) if unknown.any? || missing.any?
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

require 'anima/error'
require 'anima/attribute'

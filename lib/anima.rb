require 'adamantium'
require 'equalizer'
require 'abstract_type'

# Main library namespace and mixin
# @api private
class Anima < Module
  include Adamantium::Flat, Equalizer.new(:attributes)

  INSTANCE_METHODS = %i[to_h with].freeze
  private_constant(*constants(false))

  # Return names
  #
  # @return [AttributeSet]
  attr_reader :attributes

  # Initialize object
  #
  # @return [undefined]
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
  def remove(*names)
    new(attribute_names - names)
  end

  # Return attributes hash for instance
  #
  # @param [Object] object
  #
  # @return [Hash]
  def attributes_hash(object)
    attributes.each_with_object({}) do |attribute, attributes_hash|
      attributes_hash[attribute.name] = attribute.get(object)
    end
  end

  # Return attribute names
  #
  # @return [Enumerable<Symbol>]
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
    def initialize(attributes)
      self.class.anima.initialize_instance(self, attributes)
    end

    # Return a hash representation of an anima infected object
    #
    # @example
    #   anima.to_h # => { :foo => : bar }
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
    # @api public
    def with(attributes)
      self.class.new(to_h.update(attributes))
    end
  end # InstanceMethods

  private

  # Infect the descendant with anima semantics
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  def included(descendant)
    descendant.instance_exec(self, attribute_names) do |anima, names|
      # Define anima method
      define_singleton_method(:anima) { anima }

      # Define instance methods
      include InstanceMethods
      protected(*INSTANCE_METHODS)

      # Define attribute readers
      attr_reader(*names)
      protected(*names)

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
  def new(attributes)
    self.class.new(*attributes)
  end

  # Anima with default attribute readers set to public visiblity
  class Public < self
    # Infect the descendant with anima semantics
    #
    # @param [Class, Module] scope
    #
    # @return [undefined]
    def included(descendant)
      super
      descendant.instance_exec(attribute_names) do |attribute_names|
        public(*attribute_names)
        public(*INSTANCE_METHODS)
      end
    end
  end
end # Anima

require 'anima/error'
require 'anima/attribute'

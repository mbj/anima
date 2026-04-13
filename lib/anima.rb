# frozen_string_literal: true

require 'adamantium'
require 'equalizer'

# Declarative attribute definition for value objects
#
# @example
#   class Person
#     include Anima.new(:name, :age)
#   end
#
# @api public
class Anima < Module
  include Equalizer.new(:attributes)
  include Adamantium::Flat

  # Attributes defined on this anima
  #
  # @return [Array<Attribute>]
  #
  # @example
  #   Anima.new(:foo, :bar).attributes
  attr_reader :attributes

  # Initialize anima with attribute names
  #
  # @param [Array<Symbol>] names
  #
  # @return [void]
  #
  # @example
  #   Anima.new(:foo, :bar)
  def initialize(*names)
    @attributes = names.uniq.map { |name| Attribute.new(name) }.freeze
  end

  # Return new anima with attributes added
  #
  # @param [Array<Symbol>] names
  #
  # @return [Anima]
  #
  # @example
  #   anima = Anima.new(:foo)
  #   anima.add(:bar) # equals Anima.new(:foo, :bar)
  def add(*names)
    self.class.new(*(attribute_names + names))
  end

  # Return new anima with attributes removed
  #
  # @param [Array<Symbol>] names
  #
  # @return [Anima]
  #
  # @example
  #   anima = Anima.new(:foo, :bar)
  #   anima.remove(:bar) # equals Anima.new(:foo)
  def remove(*names)
    self.class.new(*(attribute_names - names))
  end

  # Return attributes hash for object
  #
  # @param [Object] object
  #
  # @return [Hash{Symbol => Object}]
  #
  # @example
  #   anima.attributes_hash(person) # => { name: 'Markus', age: 30 }
  def attributes_hash(object)
    attributes.to_h { |attribute| [attribute.name, attribute.get(object)] }
  end

  # Return attribute names
  #
  # @return [Array<Symbol>]
  #
  # @example
  #   Anima.new(:foo, :bar).attribute_names # => [:foo, :bar]
  def attribute_names
    attributes.map(&:name)
  end
  memoize :attribute_names

  # Initialize instance with attribute values
  #
  # @param [Object] object
  # @param [Hash{Symbol => Object}] attribute_hash
  #
  # @return [self]
  #
  # @example
  #   anima.initialize_instance(object, foo: 1, bar: 2)
  def initialize_instance(object, attribute_hash)
    assert_known_attributes(object.class, attribute_hash)
    attributes.each { |attribute| attribute.load(object, attribute_hash) }
    self
  end

  # Instance methods mixed into classes that include Anima
  module InstanceMethods
    # Initialize an anima-defined object
    #
    # @param [Hash{Symbol => Object}] attributes
    #
    # @return [void]
    #
    # @example
    #   Person.new(name: 'Markus', age: 30)
    def initialize(attributes)
      self.class.anima.initialize_instance(self, attributes)
    end

    # Return hash representation
    #
    # @return [Hash{Symbol => Object}]
    #
    # @example
    #   person.to_h # => { name: 'Markus', age: 30 }
    #
    # @api public
    def to_h
      self.class.anima.attributes_hash(self)
    end

    # Return copy with updated attributes
    #
    # @param [Hash{Symbol => Object}] attributes
    #
    # @return [Object]
    #
    # @example
    #   person.with(name: 'John') # => #<Person name="John" age=30>
    #
    # @api public
    def with(attributes)
      self.class.new(to_h.merge(attributes))
    end
  end

  private

  # Hook called when anima is included into a class
  #
  # @param [Class, Module] descendant
  #
  # @return [void]
  #
  # @api private
  def included(descendant)
    anima = self
    names = attribute_names

    descendant.define_singleton_method(:anima) { anima }
    descendant.include(InstanceMethods)
    descendant.attr_reader(*names)
    descendant.include(Equalizer.new(*names))
  end

  # Validate that attribute hash keys match expected attributes
  #
  # @param [Class] klass
  # @param [Hash{Symbol => Object}] attribute_hash
  #
  # @return [void]
  #
  # @raise [Error]
  #
  # @api private
  def assert_known_attributes(klass, attribute_hash)
    keys = attribute_hash.keys
    unknown = keys - attribute_names
    missing = attribute_names - keys

    return if unknown.empty? && missing.empty?

    raise Error.new(klass, missing, unknown)
  end
end

require 'anima/error'
require 'anima/attribute'

require 'adamantium'
require 'equalizer'
require 'abstract_type'

# Main library namespace and mixin
class Anima < Module
  include Adamantium::Flat, Equalizer.new(:attributes)

  # A module definining an #initialize method suitable for anima classes
  #
  # Including #initialize via a module supports overwriting this default
  # constructor provided by anima, by allowing to call #super
  #
  # @return [Module]
  #
  # @api private
  def self.constructor
    Module.new do
      define_method :initialize do |attributes|
        self.class.anima.initialize_instance(self, attributes)
      end
    end
  end

  # Return names
  #
  # @return [AttriuteSet]
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
    @attributes = names.uniq.map { |name| Attribute.new(name) }.freeze
  end

  # Return new anima with attributes removed
  #
  # @return [Anima]
  #
  # @example
  #   anima = Anima.new(:foo)
  #   anima.add(:foo) # equals Anima.new(:foo, :bar)
  #
  # @api public
  #
  def remove(*names)
    new(attribute_names - names)
  end

  # Return new anima with attributes added
  #
  # @return [Anima]
  #
  # @example
  #   anima = Anima.new(:foo, :bar)
  #   anima.remove(:bar) # equals Anima.new(:foo)
  #
  # @api private
  #
  def add(*names)
    new(attribute_names + names)
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
    attributes.each do |attribute|
      attribute.load(object, attribute_hash)
    end

    overflow = attribute_hash.keys - attribute_names

    unless overflow.empty?
      raise Error::Unknown.new(object.class, overflow)
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
  def included(scope)
    define_anima_method(scope)
    define_initializer(scope)
    define_attribute_readers(scope)
    define_attribute_hash_reader(scope)
    define_equalizer(scope)
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

  # Define anima method on scope
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_anima_method(scope)
    anima = self

    scope.define_singleton_method(:anima) do
      anima
    end
  end

  # Define equalizer on scope
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_equalizer(scope)
    equalizer = Equalizer.new(*attribute_names)
    scope.class_eval { include equalizer }
  end

  # Define attribute readers
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_attribute_readers(scope)
    attributes.each do |attribute|
      attribute.define_reader(scope)
    end
  end

  # Define initializer
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_initializer(scope)
    constructor = self.class.constructor
    scope.class_eval { include constructor }
  end

  # Define attribute hash reader
  #
  # @param [Class, Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_attribute_hash_reader(scope)
    scope.define_singleton_method(:attributes_hash) do |object|
      anima.attributes_hash(object)
    end
  end
end

require 'anima/error'
require 'anima/attribute'
require 'anima/update'

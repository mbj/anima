require 'backports'
require 'adamantium'
require 'equalizer'
require 'abstract_type'

# Main library namespace and mixin
class Anima < Module
  include Adamantium::Flat

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
    @attributes = names.map { |name| Attribute.new(name) }.freeze
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
    define_initializer(scope)
    define_attribute_readers(scope)
    define_attribute_hash_reader(scope)
    define_equalizer(scope)
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
    scope.send(:include, Equalizer.new(*attribute_names))
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
    anima = self

    scope.send(:define_method, :initialize) do |attributes|
      anima.initialize_instance(self, attributes)
    end
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
    anima = self

    scope.define_singleton_method(:attribute_hash) do |object|
      anima.attributes_hash(object)
    end
  end
end

require 'anima/error'
require 'anima/attribute'

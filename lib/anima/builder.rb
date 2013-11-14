# encoding: utf-8

class Anima

  # Builds an anima infected class
  class Builder

    # Static instance methods for anima infected classes
    module Methods
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
    end # Methods

    include Adamantium::Flat

    # Infect +descendant+ with anima
    #
    # @param [Anima] anima
    #   the anima instance used for infection
    #
    # @param [Class, Module] descendant
    #   the object to infect
    #
    # @return [undefined]
    #
    # @api private
    def self.call(anima, descendant)
      new(anima, descendant).call
    end

    # Initialize a new instance
    #
    # @param [Anima] anima
    #   the anima instance used for infection
    #
    # @param [Class, Module] descendant
    #   the object to infect
    #
    # @return [undefined]
    #
    # @api private
    def initialize(anima, descendant)
      @anima      = anima
      @names      = anima.attribute_names
      @descendant = descendant
    end

    # Infect the instance with anima
    #
    # @return [undefined]
    #
    # @api private
    def call
      define_equalizer
      define_anima_method
      define_attribute_readers
      descendant_exec do
        include Methods
      end
    end

    private

    # Define equalizer
    #
    # @return [undefined]
    #
    # @api private
    def define_equalizer
      descendant_exec(@names) do |names|
        include Equalizer.new(*names)
      end
    end

    # Define anima method
    #
    # @return [undefined]
    #
    # @api private
    def define_anima_method
      descendant_exec(@anima) do |anima|
        define_singleton_method(:anima) { anima }
      end
    end

    # Define attribute readers
    #
    # @return [undefined]
    #
    # @api private
    def define_attribute_readers
      descendant_exec(@names) do |names|
        attr_reader(*names)
      end
    end

    # Deduplicate instance_exec inside descendant's scope
    #
    # @param [*] *args
    #   arguments to pass to instance_exec
    #
    # @param [Proc] &block
    #   the block to eval
    #
    # @return [undefined]
    #
    # @api private
    def descendant_exec(*args, &block)
      @descendant.instance_exec(*args, &block)
    end
  end # Builder
end # Anima

# encoding: utf-8

class Anima

  # Abstract base class for anima errors
  class Error < RuntimeError

    # Error for unknown attributes
    class Unknown < self
    end

    # Error for missing attributes
    class Missing < self
    end

    include AbstractType

    DOUBLE_COLON = '::'.freeze

    # Initialize object
    #
    # @param [Object] object
    # @param [Enumerable<Symbol>] names
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(object, names)
      super("#{name} attribute(s) #{names.inspect} for #{object.class}")
    end

    private

    def name
      self.class.name.split(DOUBLE_COLON).last
    end
  end # Error
end # Anima

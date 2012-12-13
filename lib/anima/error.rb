class Anima

  # Abstract base class for anima errors
  class Error < RuntimeError
    include AbstractType

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
end

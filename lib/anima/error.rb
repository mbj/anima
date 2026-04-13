# frozen_string_literal: true

class Anima
  # Error raised when attribute validation fails
  class Error < RuntimeError
    # Format string for error messages
    FORMAT = '%s attributes missing: %s, unknown: %s'
    private_constant(:FORMAT)

    # Initialize error with class and attribute details
    #
    # @param [Class] klass
    # @param [Array<Symbol>] missing
    # @param [Array<Symbol>] unknown
    #
    # @return [void]
    #
    # @example
    #   Error.new(Person, [:name], [:extra])
    def initialize(klass, missing, unknown)
      super(format(FORMAT, klass, missing, unknown))
    end
  end
end

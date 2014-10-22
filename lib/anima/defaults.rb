class Anima

  # Define constructor defaults
  #
  # @example
  #
  #   class Foo
  #     include Anima.new(:foo, :bar),
  #             Anima::Defaults.new(foo: 3, :bar: 4)
  #   end
  #
  class Defaults < Module
    def initialize(defaults)
      @defaults = defaults
    end

    def included(descendant)
      descendant.instance_exec(@defaults) do |defaults|
        define_singleton_method(:anima_defaults) { defaults }
        prepend InstanceMethods
      end
    end

    module InstanceMethods
      def initialize(attributes = {})
        super(self.class.anima_defaults.merge(attributes))
      end
    end
  end
end

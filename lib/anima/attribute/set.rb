module Anima
  class Attribute
    class Set < self
      DEFAULT = Default::Generator.new { ::Set.new }
    end
  end
end

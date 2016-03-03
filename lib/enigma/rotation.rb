module Enigma
  class Rotation
    attr_reader :key
    def initialize(key)
      @key = key.to_s.split('')
    end

    def generate(first, second)
      @key[first, second].join('').to_i
    end

    def a
      generate(0, 2)
    end

    def b
      generate(1, 2)
    end

    def c
      generate(2, 2)
    end

    def d
      generate(3, 2)
    end
  end
end
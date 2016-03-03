module Enigma
  class EnigmaKey
    attr_reader :rotation
    def initialize(date = today, key = rand_key)
      @offset = Offset.new(today)
      @rotation = Rotation.new(key)
    end

    def today
      date = Time.now.strftime('%d, %m, %y').to_s
      date.gsub!(/\,/, '').split(' ').join('').to_s
    end

    def rand_key
      rand(999_99).to_s.center(5, rand(9).to_s)
    end

    def a
      @offset.a + @rotation.a
    end

    def b
      @offset.b + @rotation.b
    end

    def c
      @offset.c + @rotation.c
    end

    def d
      @offset.d + @rotation.d
    end
  end
end
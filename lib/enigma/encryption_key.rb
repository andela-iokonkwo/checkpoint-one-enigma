module Enigma
  class EncryptionKey
    def initialize(date = today, key = rand_key)
      @offset = OffSet.new(date)
      @key = Key.new(key)
    end

    def today
      date = Time.now.strftime('%d, %m, %y').to_s
      date.gsub!(/\,/, '').split(' ').join('').to_s
    end

    def rand_key
      rand(999_99).to_s.center(5, rand(9).to_s)
    end

    def key
      @key.key
    end

    def date
      @offset.date
    end

    def a
      @offset.a + @key.a
    end

    def b
      @offset.b + @key.b
    end

    def c
      @offset.c + @key.c
    end

    def d
      @offset.d + @key.d
    end
  end
end
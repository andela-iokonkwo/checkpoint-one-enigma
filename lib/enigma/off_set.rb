module Enigma
  class OffSet
    attr_reader :date
    def initialize(date)
      @date = date
      date_without_leading_zero = date.sub(/^0/, '')
      @date_squared = date_without_leading_zero.to_i ** 2
    end

    def last_four
      @last_four ||= @date_squared.to_s.split('')[-4, 4].map(&:to_i)
    end

    def a
      last_four[0]
    end

    def b
      last_four[1]
    end

    def c
      last_four[2]
    end

    def d
      last_four[3]
    end
  end
end
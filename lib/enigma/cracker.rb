module Enigma
  class Cracker
    include CharacterMapper

    def initialize(file_store, date)
      @file_store = file_store
      @offset = OffSet.new(date)
    end

    def generate_key_for(file_name)
      @key = []
      encryption_key = generate_encryption_key_by(file_name)
      @key[0] = encryption_key[0] - @offset.a
      @key[1] = encryption_key[1] - @offset.b
      @key[2] = encryption_key[2] - @offset.c
      @key[3] = encryption_key[3] - @offset.d
      start_generating
      # require "pry"; binding.pry
    end

    # private

    def generate_encryption_key_by(file_name)
      set = map_encrypted_to_known(file_name)
      encryption_key = []
      (0..3).each do |index|
        chars_set = set[index]
        encryption_key[index] = position_diff(chars_set)
      end
      encryption_key
    end

     def map_encrypted_to_known(file_name)
      text = @file_store.get(file_name)
      known_digit = text.size % 4
      known_digit += 4 if known_digit < 4
      encrypted_chars = text[-known_digit, 4]
      known_chars = "..end.."[-known_digit, 4].split('')
      known_chars.zip(encrypted_chars)
    end

    def position_diff(chars_set)
      character_hash[chars_set[1]] - character_hash[chars_set[0]]
    end

    def start_generating(key = @key)
      final_key = []
      index = 0
      while index < 3
        first = make_positive(key[index])
        second = make_positive(key[index + 1])
        final_key[index], final_key[index + 1] = rotate_to_match(first, second)
        index += 1
      end
      final_key.map!(&:to_s)
      "#{final_key[0]}#{final_key[1][1]}#{final_key[3]}".to_i
    end

    def make_positive(num)
      return num unless num < 0
      make_positive(num + 39)
    end

    def rotate_to_match(first, second)
      original_second = second
      while first < 100
        second = original_second
        while second < 100
          return [first, second] if key_equal(first, second)
          second += 39
        end
        first += 39
      end
    end

    def key_equal(first, second)
      first.to_s[1] == second.to_s[0]
    end
  end
end



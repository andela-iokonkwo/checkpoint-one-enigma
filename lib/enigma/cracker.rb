module Enigma
  class Cracker
    include CharacterMapper

    def initialize(file_name, file_store, date)
      @file_store = file_store
      @offset = OffSet.new(date)
      encryption_key(file_name)
    end

    def map_encrypted_to_known_values(file_name)
      text = @file_store.get(file_name)
      known_digit = text.size % 4
      known_digit += 4 if known_digit < 4
      encrypted_chars = text[-known_digit, 4]
      known_chars = "..end.."[-known_digit, 4].split('')
      encrypted_chars.zip(known_chars)
    end

    def encryption_key(file_name)
      context = map_encrypted_to_known_values(file_name)
      @encryption_key = []
      (0..3).each do |index|
        current_set = context[index]
        @encryption_key[index] = calculate_diff(current_set)
      end
    end

    def calculate_diff(set)
      character_hash[set[0]] - character_hash[set[1]]
    end

    def generate_key
      @normal_keys = []
      @normal_keys[0] = @encryption_key[0] - @offset.a
      @normal_keys[1] = @encryption_key[1] - @offset.b
      @normal_keys[2] = @encryption_key[2] - @offset.c
      @normal_keys[3] = @encryption_key[3] - @offset.d
      generate_normal_key
    end

    def generate_normal_key
      final_keys = []
      index = 0
      while index < 3
        first = make_positive(@normal_keys[index])
        second = make_positive(@normal_keys[index + 1])
        final_keys[index], final_keys[index + 1] = match(first, second)
        index += 1
      end
      final_keys.map!(&:to_s)
      "#{final_keys[0]}#{final_keys[1][1]}#{final_keys[3]}".to_i
    end

    def make_positive(num)
      while num < 0
        num += 39
      end
      num
    end

    def match(first, second)
      original_second = second
      catch(:found) do
        while first < 100
          second = original_second
          while second < 100
            throw :found if key_equal(first, second)
            second += 39
          end
          first += 39
        end
      end
      [first, second]
    end

    def key_equal(first, second)
      first.to_s[1] == second.to_s[0]
    end
  end
end



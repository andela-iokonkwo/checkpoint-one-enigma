
module Enigma
  class Engine

    def initialize(key_gen, file_store)
      @key_gen = key_gen
      @file_store = file_store
      encryption_type = [:a, :b, :c, :d]
    end

    def character_map
      @character_map ||= ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","]
    end

    def character_hash
      @character_hash ||= Hash[character_map.zip (0..character_map.size)]
    end

    def key_and_offset
      key = key_gen.rotation.key
      date = key_gen.offset.date
      [key, offset]
    end

    def map_encrypted_to_known_values(file_name)
      text = @file_store.get(file_name)
      known_digit = text.size % 4
      known_digit += 4 if known_digit < 4
      encrypted_chars = text[-known_digit, 4]
      known_chars = "..end.."[-known_digit, 4].split('')
      encrypted_chars.zip(known_chars)
    end

    def find_key(file_name)
      context = map_encrypted_to_known_values(file_name)
      key = []
      index = 0
      while index < 4
        current_set = context[index]
        if index == 3
          key[index] = calculate_diff current_set
        else
        next_set = context[index + 1] unless index == 3
        current_set_key = calculate_diff current_set
        next_set_key = calculate_diff next_set if next_set
        key[index] = calculate_key(current_set_key, next_set_key)
      end
    end

    def calculate_diff(set)
      character_hash[set[0]] - character_hash[set[1]]
    end

    # calculate_key


    def save_and_report(file_name, output_file_name, &block)
      text_in_array = file_store.get(file_name)
      converted_text = generate_message(text_in_array, &block).join('')
      file_store.create(converted, output_file_name)
      key, offset = key_and_offset
      file_store.report_message(output_file_name, key, date)
    end

    def generate_message(text, &block)
      encrytion_index = 0
      text.map do |char|
        position = key_gen.send(encryption_type[encrytion_index])
        encrytion_index += 1
        encrytion_index = 0 if encrytion_index == 4
        encrypt_single(char, position)
      end
    end


    def rotate_single(char, shift, &block)
      current_character_position = character_hash[char]
      # (current_character_position + pos)
      new_character_position = yield(current_character_position, shift) % 38
      character_map[new_character_position]
    end
  end
end

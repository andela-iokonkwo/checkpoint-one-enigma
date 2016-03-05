module Enigma
  class Engine
    include CharacterMapper

    def initialize(encryption_key, file_store)
      @encryption_key = encryption_key
      @file_store = file_store
      @encryption_rotation = [:a, :b, :c, :d]
    end

    def key_and_date
      key = @encryption_key.key.join("").to_i
      date = @encryption_key.date
      [key, date]
    end

    # strategy = :+ => encryption
    # strategy = :- => decryption
    def save_and_report(file_name, output_file_name, strategy)
      text_in_array = @file_store.get(file_name)
      converted_text = generate_message(text_in_array, strategy).join('')
      @file_store.create(converted_text, output_file_name)
      key, date = key_and_date
      @file_store.report_message(output_file_name, key, date)
    end

    def generate_message(text, strategy)
      encryption_key_index = 0
      text.map do |char|
        # current_rotation can be a, b, c or d
        current_rotation = @encryption_rotation[encryption_key_index]
        position = @encryption_key.send(current_rotation)
        encryption_key_index += 1
        encryption_key_index = 0 if encryption_key_index == 4
        rotate_single(char, position, strategy)
      end
    end


    def rotate_single(char, shift, strategy)
      character_position = character_hash[char]
      new_character_position = character_position.send(strategy, shift) % 39
      character_map[new_character_position]
    end
  end
end

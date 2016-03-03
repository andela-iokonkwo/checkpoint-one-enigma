module Enigma
  class Engine
    include CharacterMapper

    def initialize(encryption_key, file_store)
      @encryption_key = encryption_key
      @file_store = file_store
      @encryption_type = [:a, :b, :c, :d]
    end

    def key_and_date
      key = @encryption_key.key
      date = @encryption_key.date
      [key, date]
    end

    def save_and_report(file_name, output_file_name, &block)
      text_in_array = @file_store.get(file_name)
      converted_text = generate_message(text_in_array, &block).join('')
      @file_store.create(converted_text, output_file_name)
      key, date = key_and_date
      @file_store.report_message(output_file_name, key, date)
    end

    def generate_message(text, &block)
      encryption_key_index = 0
      text.map do |char|
        position = @encryption_key.send(@encryption_type[encryption_key_index])
        encryption_key_index += 1
        encryption_key_index = 0 if encryption_key_index == 4
        rotate_single(char, position, &block)
      end
    end


    def rotate_single(char, shift, &block)
      current_character_position = character_hash[char]
      new_character_position = yield(current_character_position, shift) % 39
      character_map[new_character_position]
    end
  end
end

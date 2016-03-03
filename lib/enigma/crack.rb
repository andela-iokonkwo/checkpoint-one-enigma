module Enigma
  class Crack
    def initialize(date, file_name)
      @file_name = file_name
      key = KeyGen.new(file_name)
      key_gen = EnigmaKey.new(date, key)
      @engine = Engine.new(key_gen, file_store)
    end

    def call(output_file_name)
      shift_strategy = Proc.new do |character_position, shift|
        character_position - shift
      end
      @engine.save_and_report @file_name, output_file_name, &shift_strategy
    end
  end
end
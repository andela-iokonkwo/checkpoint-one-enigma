module Enigma
  class Crack
    def initialize(date, file_name)
      @file_name = file_name
      file_store = FileStore.new
      key = Cracker.new(file_name, file_store, date).generate_key
      encryption_key = EncryptionKey.new(date, key)
      @engine = Engine.new(encryption_key, file_store)
    end

    def call(output_file_name)
      shift_strategy = Proc.new do |character_position, shift|
        character_position - shift
      end
      @engine.save_and_report @file_name, output_file_name, &shift_strategy
    end
  end
end
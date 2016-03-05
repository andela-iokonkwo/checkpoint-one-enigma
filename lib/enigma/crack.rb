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
      @engine.save_and_report @file_name, output_file_name, :-
    end
  end
end
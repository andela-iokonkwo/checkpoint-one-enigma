module Enigma
  class Crack
    def initialize(date, file_name)
      file_store = FileStore.new
      key = Cracker.new(file_store, date).generate_key_for(file_name)
      encryption_key = EncryptionKey.new(date, key)
      @engine = Engine.new(encryption_key, file_store)
    end

    def call(file_name, output_file_name)
      @engine.save_and_report file_name, output_file_name, :-
    end
  end
end
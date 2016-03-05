module Enigma
  class Decrypt

    def initialize(date, key)
      encryption_key = EncryptionKey.new(date, key)
      file_store = FileStore.new
      @engine = Engine.new(encryption_key, file_store)
    end

    def call(file_name, output_file_name)
      @engine.save_and_report file_name, output_file_name, :-
    end
  end
end
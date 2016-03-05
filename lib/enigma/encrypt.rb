module Enigma
  class Encrypt
    def initialize
      encryption_key = EncryptionKey.new
      file_store = FileStore.new
      @engine = Engine.new(encryption_key, file_store)
    end

    def call(file_name, output_file_name)
      @engine.save_and_report file_name, output_file_name, :+
    end
  end
end
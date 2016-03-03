module Enigma
  class KeyGen
    def initialize(file_store)
      @file_store = file_store
    end

    def map_encrypted_to_known_values
      text = @file_store.get
      known_digit = text.size % 4
      known_digit += 4 if known_digit < 4
      encrypted_chars = text[-known_digit, 4]
      known_chars = "..end.."[-known_digit, 4].split('')
      Hash[encrypted_chars.zip(known_chars)]
    end
  end
end

module Enigma
  module CharacterMapper
    def character_map
      @character_map ||= ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","]
    end

    def character_hash
      @character_hash ||= Hash[character_map.zip (0..character_map.size)]
    end
  end
end
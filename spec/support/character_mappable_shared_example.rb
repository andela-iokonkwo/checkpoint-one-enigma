RSpec.shared_examples "a character_mappable" do

  it { is_expected.to respond_to :character_map }

  it { is_expected.to respond_to :character_hash }

  describe "#character_map" do
    let(:character_map) do
      ["a","b","c","d","e","f","g","h","i","j","k",
        "l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0",
        "1","2","3","4","5","6","7","8","9"," ",".",","]
    end

    it { expect(subject.character_map).to eq character_map }
  end

   describe "#character_hash" do
    let(:character_hash) do
      {"a" => 0,"b" => 1,"c" => 2,"d" => 3,"e" => 4,"f" => 5,"g" => 6,"h" =>7,
        "i" => 8,"j" => 9,"k" => 10, "l" => 11,"m" => 12,"n" => 13,"o" => 14,
        "p" => 15,"q" => 16,"r" => 17,"s" => 18,"t" => 19,"u" => 20,"v" => 21,
        "w" => 22,"x" => 23,"y" => 24,"z" => 25,"0" => 26,"1" => 27,"2" => 28,
        "3" => 29,"4" => 30,"5" => 31,"6" => 32,"7" => 33,"8" => 34,"9" => 35,
        " " => 36,"." => 37,"," => 38}
    end

    it { expect(subject.character_hash).to eq character_hash }
  end
end
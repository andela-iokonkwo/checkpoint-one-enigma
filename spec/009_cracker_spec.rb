require 'spec_helper'

describe Enigma::Cracker do
  subject { Enigma::Cracker.new(Enigma::FileStore.new, "040316") }

  describe "#key_equal" do
    it { expect(subject.key_equal 57, 79).to be_truthy }
    it { expect(subject.key_equal 33, 38).to be_truthy }
    it { expect(subject.key_equal 62, 21).to be_truthy }

    it { expect(subject.key_equal 48, 39).to be_falsy }
    it { expect(subject.key_equal 19, 26).to be_falsy }
    it { expect(subject.key_equal 70, 84).to be_falsy }
  end

  describe "#make_positive" do
    context "by recursively adding 39" do
      it { expect(subject.make_positive -20).to eq 19 }
      it { expect(subject.make_positive -1).to eq 38 }
      it { expect(subject.make_positive -63).to eq 15 }
    end
  end

  describe "#rotate_to_match" do
    it { expect(subject.rotate_to_match 35, 14).to eq [35, 53] }
    it { expect(subject.rotate_to_match 14, 37).to eq [53, 37] }
    it { expect(subject.rotate_to_match 37, 33).to eq [37, 72] }
  end

  describe "#start_generating_key" do
    it { expect(subject.start_generating [-4, 14, -41, -6]).to eq 35372 }
    it { expect(subject.start_generating [-4, 12, -21, -35]).to eq 35182 }
  end

  describe "#position_diff" do
    it { expect(subject.position_diff ["n", "s"]).to eq 5 }
    it { expect(subject.position_diff ["d", "x"]).to eq 20 }
    it { expect(subject.position_diff [".", "v"]).to eq -16 }
    it { expect(subject.position_diff [".", "i"]).to eq -29 }
  end

  describe "#map_encrypted_to_known" do
    it do
      FakeFS do
        File.open("encrypted.txt", "w") do |file|
          file.write "fvznk04so48ws8,0w,d40dc84svosxvi"
        end
        output = [["n", "s"], ["d", "x"], [".", "v"], [".", "i"]]
        expect(subject.map_encrypted_to_known "encrypted.txt").to eq output
      end
    end

    it do
      FakeFS do
        File.open("ciphered.txt", "w") do |file|
          file.write "m94.rb9dvfahzjel3nip7rht.60,z.06"
        end
        output = [["n", "z"], ["d", "."], [".", "0"], [".", "6"]]
        expect(subject.map_encrypted_to_known "ciphered.txt").to eq output
      end
    end
  end

  describe "#generate_encryption_key_by" do
    it do
      allow(subject).to receive(:map_encrypted_to_known) do
        [["n", "z"], ["d", "."], [".", "0"], [".", "6"]]
      end
      expect(subject.generate_encryption_key_by "file_name").to  eq [12, 34, -11, -5]
    end

    it do
      allow(subject).to receive(:map_encrypted_to_known) do
        [["n", "s"], ["d", "x"], [".", "v"], [".", "i"]]
      end
      expect(subject.generate_encryption_key_by "file_name").to eq [5, 20, -16, -29]
    end
  end

  describe "#generate_key_for" do
    let(:file_name) { "encrypted.txt" }
    it do
      allow(subject).to receive(:generate_encryption_key_by) { [12, 34, -11, -5] }
      subject.generate_key_for file_name
      expect(subject.instance_variable_get(:@key)).to eq [3, 26, -16, -11]
    end

    it do
      allow(subject).to receive(:generate_encryption_key_by) { [5, 20, -16, -29] }
      subject.generate_key_for(file_name)
      expect(subject.instance_variable_get(:@key)).to eq [-4, 12, -21, -35]
    end
  end
end

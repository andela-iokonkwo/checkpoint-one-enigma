require 'spec_helper'
require 'support/character_mappable_shared_example'

describe Enigma::Engine do
  let(:encryption_key) { Enigma::EncryptionKey.new("040316", 35372) }
  let(:file_store) { Enigma::FileStore.new }
  let(:encryption_shift_strategy) { :+ }

  let(:decryption_shift_strategy) { :- }

  subject { Enigma::Engine.new(encryption_key, file_store) }

  context "subject includes character_mapper module" do
    it_behaves_like "a character_mappable"
  end

  describe "#key_and_date" do
    it { expect(subject.key_and_date).to eq [35372, "040316"] }
  end

  describe "#rotate_single" do
    context "encrytion shift_strategy" do
      let(:shift_strategy) { encryption_shift_strategy }

      it { expect(subject.rotate_single("a", 105, shift_strategy)).to eq "1" }
      it { expect(subject.rotate_single("b", 68, shift_strategy)).to eq "4" }
      it { expect(subject.rotate_single("c", 14, shift_strategy)).to eq "q" }
      it { expect(subject.rotate_single("d", 96, shift_strategy)).to eq "v" }
    end


    context "decrytion shift_strategy" do
      let(:shift_strategy) { decryption_shift_strategy }

      it { expect(subject.rotate_single("v", 99, shift_strategy)).to eq "a" }
      it { expect(subject.rotate_single("k", 9, shift_strategy)).to eq "b" }
      it { expect(subject.rotate_single("s", 16, shift_strategy)).to eq "c" }
      it { expect(subject.rotate_single("1", 24, shift_strategy)).to eq "d" }
    end
  end

  describe "#generate_message" do
    context "encrytion shift_strategy" do
      let(:shift_strategy) { encryption_shift_strategy }
      let(:text) do
        ["a","b","c","d","e","f","g","h","i","j","k",
        "l","m","n","o","p","q","r","s","t","u","v","w","s","y","z",".",".",
        "e","n", "d",".","."]
      end
      let(:message) do
        ["f","x","f","d","j","1","j","h","n","5","n",
        "l","r","9","r","p","v","a","v","t","z","e","z","s","3","i","b",".",
        "j","9", "g",".","d"]
      end

      it { expect(subject.generate_message(text, shift_strategy)).to eq message }
    end

    context "decrytion shift_strategy" do

      let(:shift_strategy) { decryption_shift_strategy }
      let(:text) do
        ["f","x","f","d","j","1","j","h","n","5","n",
        "l","r","9","r","p","v","a","v","t","z","e","z","s","3","i","b",".",
        "j","9", "g",".","d"]
      end
      let(:message) do
        ["a","b","c","d","e","f","g","h","i","j","k",
        "l","m","n","o","p","q","r","s","t","u","v","w","s","y","z",".",".",
        "e","n", "d",".","."]
      end

      it { expect(subject.generate_message(text, shift_strategy)).to eq message }
    end
  end

  describe "#save_and_report" do
     context "encrytion shift_strategy" do
      let(:shift_strategy) { encryption_shift_strategy }
      let(:text) { "abcdefghijklmnopqrstuvwsyz..end.." }
      let(:file_name) { "message.txt" }
      let(:output_file_name) { "encrypted.txt" }
      let(:output) { "fxfdj1jhn5nlr9rpvavtzezs3ib.j9g.d" }


      it do
        FakeFS do
          File.open(file_name, "w") do |file|
            file.write text
          end
          report = subject.save_and_report(file_name,
                                           output_file_name,
                                           shift_strategy)
          File.open(output_file_name, "r") do |file|
            expect(file.read).to eq output
          end
          expect(report).to eq "Created: encrypted.txt\nKey: 35372\nDate: 040316"
        end
      end
    end

    context "decrytion shift_strategy" do

      let(:shift_strategy) { decryption_shift_strategy }
      let(:text) { "fxfdj1jhn5nlr9rpvavtzezs3ib.j9g.d" }
      let(:file_name) { "encrypted.txt" }
      let(:output_file_name) { "decrypted.txt" }
      let(:output) { "abcdefghijklmnopqrstuvwsyz..end.." }


      it do
        FakeFS do
          File.open(file_name, "w") do |file|
            file.write text
          end
          report = subject.save_and_report(file_name,
                                           output_file_name,
                                           shift_strategy)
          File.open(output_file_name, "r") do |file|
            expect(file.read).to eq output
          end
          expect(report).to eq "Created: decrypted.txt\nKey: 35372\nDate: 040316"
        end
      end
    end
  end
end


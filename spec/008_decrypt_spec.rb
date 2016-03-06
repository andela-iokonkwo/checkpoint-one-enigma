require 'spec_helper'
require 'support/enigma_command_shared_example'

describe Enigma::Decrypt do
  subject { Enigma::Decrypt.new("040316", 35372) }

  it_behaves_like "an enigma command", type: "decrypt" do
    let(:shift_strategy) { :- }
    let(:file_name) { "encrypted.txt" }
    let(:output_file_name) { "decrypted.txt" }
  end
end

require 'spec_helper'
require 'support/enigma_command_shared_example'

describe Enigma::Crack do
  let(:file_name) { "encrypted.txt" }
  let(:output_file_name) { "cracked.txt" }

  subject { Enigma::Crack.new("040316", file_name) }

  it_behaves_like "an enigma command", type: "crack" do
    let(:shift_strategy) { :- }
  end
end

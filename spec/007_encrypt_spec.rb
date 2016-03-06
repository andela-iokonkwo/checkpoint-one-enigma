require 'spec_helper'
require 'support/enigma_command_shared_example'

describe Enigma::Encrypt do
  it_behaves_like "an enigma command", type: "encrypt" do
    let(:shift_strategy) { :+ }
    let(:file_name) { "message.txt" }
    let(:output_file_name) { "encrypted.txt" }
  end
end

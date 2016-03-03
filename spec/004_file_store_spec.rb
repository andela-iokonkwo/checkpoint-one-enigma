require 'spec_helper'

describe Enigma::FileStore do

  describe "#get" do
    let(:io) { StringIO.new("abcdefghijklmnopqrstuvwxyz..end..") }
    let(:file_name) { "message.txt"}

    it do
      allow(File).to receive(:open).with(file_name,'r').and_yield( io )
      subject.get(file_name)
      expect(subject.instance_variable_get(:@data).join("")).to eq io.string
    end
  end

  describe "#create" do
    let(:io) { StringIO.new }
    let(:content) { "d.p7hct.lgxcpk1gto5kxs9j1wl2hkq2b" }
    let(:file_name) { "encrypted.txt"}

    it do
      allow(File).to receive(:open).with(file_name,'w').and_yield( io )
      subject.create(content, file_name)
      expect(io.string).to eq content
    end
  end

  describe "#respond_message" do
    let(:message) { subject.report_message("encrypted.txt", "030316", 55190) }
    let(:content) { "Created: encrypted.txt\nKey: 030316\nDate: 55190" }
    it { expect(message).to eq content }
  end
end

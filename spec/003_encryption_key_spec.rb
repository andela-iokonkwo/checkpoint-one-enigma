require 'spec_helper'

describe Enigma::EncryptionKey do
  subject { Enigma::EncryptionKey.new("030316", 55190) }

  context "@offset" do
    let(:offset) { subject.instance_variable_get(:@offset) }

    it { expect(offset).to be_an_instance_of Enigma::OffSet }
  end

  context "@key" do
    let(:key) { subject.instance_variable_get(:@key) }

    it { expect(key).to be_an_instance_of Enigma::Key }
  end

  describe "#new" do
    let(:encryption_key) { Enigma::EncryptionKey }

    context "no argument" do
      it { expect { encryption_key.new }.not_to raise_error(ArgumentError) }
    end

    context "2 argument" do
      it { expect { encryption_key.new("030316", 55190) }.not_to raise_error(ArgumentError) }
    end
  end

  describe "#today" do
    it do
      allow(Time).to receive(:now) { Time.new(2016, 03, 03, 22, 25, 45, "+01:00") }
      expect(subject.today).to eq "030316"
    end
  end

  describe "#a" do
    it { expect(subject.a).to eq 64 }
  end

  describe "#b" do
    it { expect(subject.b).to eq 59 }
  end

  describe "#c" do
    it { expect(subject.c).to eq 24 }
  end

  describe "#d" do
    it { expect(subject.d).to eq 96 }
  end
end

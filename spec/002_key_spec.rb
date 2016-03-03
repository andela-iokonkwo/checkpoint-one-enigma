require 'spec_helper'

describe Enigma::Key do
  subject { Enigma::Key.new(55190) }

  describe "#a" do
    it { expect(subject.a).to eq 55 }
  end

  describe "#b" do
    it { expect(subject.b).to eq 51 }
  end

  describe "#c" do
    it { expect(subject.c).to eq 19 }
  end

  describe "#d" do
    it { expect(subject.d).to eq 90 }
  end
end

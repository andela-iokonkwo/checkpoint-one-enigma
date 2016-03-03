require 'spec_helper'

describe Enigma::OffSet do
  subject { Enigma::OffSet.new("030316") }

  context "Squared Date" do
    let(:squared_date) { subject.instance_variable_get(:@date_squared) }

    it { expect(squared_date).to eq 919059856 }
    it { expect(squared_date).not_to eq 156100036 }
  end

  describe "#last_four" do
    let(:last_four) { subject.last_four }

    it { expect(last_four).to eq [9, 8, 5, 6] }
    it { expect(last_four).not_to eq [0, 0, 3, 6] }
  end

  describe "#a" do
    it { expect(subject.a).to eq 9 }
  end

  describe "#b" do
    it { expect(subject.b).to eq 8 }
  end

  describe "#c" do
    it { expect(subject.c).to eq 5 }
  end

  describe "#d" do
    it { expect(subject.d).to eq 6 }
  end
end

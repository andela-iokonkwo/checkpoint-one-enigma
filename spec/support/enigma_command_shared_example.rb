RSpec.shared_examples "an enigma command" do |type: |
  it { is_expected.to respond_to :call }

  context "Class" do
    it { expect(subject.class.to_s).to eq "Enigma::#{type.capitalize}" }
  end

  describe "#call" do
    let(:engine) { spy('engine') }

    it "calls save_and_report engine method with #{type} strategy" do
      subject.instance_variable_set(:@engine, engine)
      subject.call(file_name, output_file_name)
      expect(engine).to have_received(:save_and_report ).
                          with(file_name, output_file_name, shift_strategy)
    end
  end
end
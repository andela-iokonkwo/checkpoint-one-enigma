require 'spec_helper'
require 'support/character_mappable_shared_example'

describe Enigma::CharacterMapper do

  it 'defines a module Enigma::CharacterMapper' do
    expect(defined?(Enigma::CharacterMapper)).to be_truthy
    expect(Enigma::CharacterMapper).to be_a(Module)
  end

  class Letters
    include Enigma::CharacterMapper
  end

  subject { Letters.new }

  it_behaves_like "a character_mappable"
end

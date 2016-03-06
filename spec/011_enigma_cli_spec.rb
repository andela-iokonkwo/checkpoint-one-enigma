require "spec_helper"

describe 'Enigma CLI' do

  it 'can encrypt' do
    'backtick is used to execute a shell command here'
    output = `bin/enigma encrypt message.txt encrypted.txt`
    expect(output).to include "Created: encrypted.txt\n"
  end

  it 'can decrypt' do
    File.open("encrypted.txt", "w") do |file|
      file.write ".flddkqihoumlsyqpw2ut01yxchelhh."
    end
    output = `bin/enigma decrypt encrypted.txt decrypted.txt 67433 060316`
    expect(output).to eq "Created: decrypted.txt\nKey: 67433\nDate: 060316\n"
  end

  it 'cannot decrypt with invalid date' do
    output = `bin/enigma decrypt encrypted.txt decrypted.txt 67433 06031`
    expect(output).to eq "The date you entered is invalid. Date must be 6 characters\n"
  end

  it 'cannot decrypt with invalid key' do
    output = `bin/enigma decrypt encrypted.txt decrypted.txt 6743 06031`
    expect(output).to eq "The key you entered is invalid. Key must be 5 characters\n"
  end

  it 'can crack' do
    File.open("encrypted.txt", "w") do |file|
      file.write ".flddkqihoumlsyqpw2ut01yxchelhh."
    end
    output = `bin/enigma crack encrypted.txt cracked.txt 060316`
    expect(output).to eq "Created: cracked.txt\nKey: 67433\nDate: 060316\n"
  end

  it 'cannot crack with invalid date' do
    output = `bin/enigma crack encrypted.txt cracked.txt 06031`
    expect(output).to eq "The date you entered is invalid. Date must be 6 characters\n"
  end
end

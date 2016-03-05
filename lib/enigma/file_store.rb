module Enigma
  class FileStore
    def initialize(io = File)
      @io = io
    end

    def get(file_name)
      return @data if @data
      @io.open(file_name, 'r') do |file|
        data = file.read
        data.gsub(/\n/, ' ')
        @data = data.split("")
      end
    rescue
      raise "Cannot find file, Run [enigma help] to see help!"
    end

    def create(txt, file_name)
      @io.open(file_name, 'w') do |file|
        file.write(txt)
      end
    end

    def report_message(new_file, key, date)
       "Created: #{new_file}\nKey: #{key}\nDate: #{date}"
    end
  end
end
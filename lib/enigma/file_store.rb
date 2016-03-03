module Enigma
  class FileStore
    def get(file_name)
      return @data if @data
      file = File.open(file_name, 'r')
      if File.exist? file
        data = file.read
        data.gsub(/\n/, ' ')
        @data = data.split("")
      end
    rescue
      raise "Cannot find file, Run [enigma help] to see help!"
    end

    def create(txt, file_name, key, date)
      file = File.open(file_name, 'w')
      file.write(txt)
      file.close
    end

    def report_message(new_file, key, date)
      "Created: #{green(new_file)}\nKey: #{red(key)}\nDate: #{blue(date)}#{msg}"
    end
  end
end
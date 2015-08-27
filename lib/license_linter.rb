require 'pry'

class LicenseLinter 



  def self.parse_file(file, directory)
    directory_file = File.open(file)
    valid_file = File.open("/Users/sophiedebenedetto/Desktop/Dev/learn-validation-project/linter/lib/valid_license.md")
    if directory_file.read == valid_file.read
      directory.success[:license] = true
      directory.valid_license = {message: "valid license", color: :green}
    end
  end
end

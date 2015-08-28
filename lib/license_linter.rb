require 'pry'

class LicenseLinter 



  def self.parse_file(file, learn_error)
    directory_file = File.open(file)
    valid_file = File.open("/Users/sophiedebenedetto/Desktop/Dev/learn-validation-project/linter/lib/valid_license.md")
    # binding.pry
    if directory_file.read == valid_file.read
      # binding.pry
      learn_error.license_error[:valid_license] = true
      learn_error.valid_license = {message: "valid license", color: :green}
      # binding.pry
    end
  end
end

require_relative './yaml_linter.rb'
require_relative './license_linter.rb'
require_relative './learn_error.rb'
require 'pry'

class DirectoryLinter

  attr_accessor :filepath, :valid_yaml, :valid_license, :present_learn, :present_license, :success 



  def initialize(filepath)
    @filepath = filepath
    @success = {learn: false, license: false, readme: false}
    @learn_error = LearnError.new
  end

  def lint_directory
    self.yaml_lint
    self.license_lint
    #self.readme_lint
    # binding.pry
    @learn_error.result_output
    @learn_error.total_errors
  end



  def has_file?(file)
    if Dir.entries(filepath).include?(file)
      true
    else
      false
    end
  end

  def yaml_lint
    if self.has_file?(".learn")
      # binding.pry
      @learn_error.yaml_error[:present_dotlearn] = true
      YamlLint.parse_file("#{filepath}/.learn", @learn_error)
    else
      @learn_error.present_learn = {message: "missing .learn file", color: :red}
    end
  end

  def license_lint
    if self.has_file?("LICENSE.md")
      @learn_error.license_error[:present_license] = true
      LicenseLinter.parse_file("#{filepath}/LICENSE.md", @learn_error)
    else
      @learn_error.present_learn = {message: "missing LICENSE.md", color: :red}

    end
  end

  def readme_lint
    if self.has_file?("README.md")
      @learn_error.readme_error[:present_readme] = true
      #parse
      
    else
      @learn_error.present_readme = {message: "missing README.md", color: :yellow}
    end
  end

end
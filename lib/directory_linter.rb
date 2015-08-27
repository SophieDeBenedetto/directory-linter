require_relative './yaml_linter.rb'
require_relative './license_linter.rb'
require 'pry'

module Logging
  ESCAPES = { :green  => "\033[32m",
              :yellow => "\033[33m",
              :red    => "\033[31m",
              :reset  => "\033[0m" }

  def info(message)
    emit(:message => message, :color => :green)
  end

  def result_output
    # binding.pry
    all_results = [valid_yaml, valid_license, present_learn, present_license].compact!
    all_results.each do |result|
      # binding.pry
      emit(result)
    end
  end


  def emit(opts={})
    color   = opts[:color]
    message = opts[:message]
    print ESCAPES[color]
    print message
    print ESCAPES[:reset]
    print "\n"
  end
end

class DirectoryLinter

  include Logging

  attr_accessor :filepath, :valid_yaml, :valid_license, :present_learn, :present_license, :success 



  def initialize(filepath)
    @filepath = filepath
    @success = {learn: false, license: false, readme: false}
  end

  def lint_directory
    self.yaml_lint
    self.license_lint
    result_output
    # self.readme_lint
   
    success
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
      YamlLint.parse_file("#{filepath}/.learn", self)
    else
      self.present_learn = {message: "missing .learn file", color: :red}
    end
  end

  def license_lint
    if self.has_file?("LICENSE.md")
      LicenseLinter.parse_file("#{filepath}/LICENSE.md", self)
    else
      self.present_learn = {message: "missing LICENSE.md", color: :red}

    end
  end

  def readme_lint
    if self.has_file?("README.md")
      #parse
      
    else
      self.present_readme = {message: "missing README.md", color: :yellow}
    end
  end

end
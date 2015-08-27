#!/usr/bin/env ruby
require 'yaml'

module Logging
  ESCAPES = { :green  => "\033[32m",
              :yellow => "\033[33m",
              :red    => "\033[31m",
              :reset  => "\033[0m" }

  def info(message)
    emit(:message => message, :color => :green)
  end

  def error(message)
    emit(:message => message, :color => :red) 
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

class YamlLint

  def self.parse_file(file, directory)
    begin
      YAML.load_file(file)
    rescue Exception => err
      directory.valid_yaml = "#{err}"
    else
      if self.validate_whitespace_for_learn(file)
        directory.success[:learn] = true
        directory.valid_yaml = {message: "valid yaml and valid whitespace.", color: :green}
      else 
        directory.valid_yaml = {message: "valid yaml but invalid whitespace", color: :red}
      end
    end
  end

  def self.validate_whitespace_for_learn(file)
    f = File.read(file)
    lines = f.split("\n")
    attributes = lines.select { |line| line.include?("-") }
    attributes.each do |attribute| 
      return false unless attribute[0..3] == "  - "
    end
    true
  end 

  # def validate_content_for_learn(file)
  #   # some code coming soon 
  # end

end


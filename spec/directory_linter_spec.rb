require 'spec_helper'
require_relative '../lib/directory_linter'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe 'DirectoryLinter' do 
  describe 'lint_directory' do 
    it 'approves directory with valid .learn file' do 
      linter = DirectoryLinter.new(FIXTURES_PATH + 'good_learn')
      expect(linter.lint_directory).to eq({:learn=>true, :license=>false, :readme=>false})
    end

    it 'approves a directory with valid LICENSE.md' do 
      linter = DirectoryLinter.new(FIXTURES_PATH + 'good_license')
      expect(linter.lint_directory).to eq({:learn=>false, :license=>true, :readme=>false})
    end

  end
end

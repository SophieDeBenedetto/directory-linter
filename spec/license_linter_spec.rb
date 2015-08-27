require 'spec_helper'
require_relative '../lib/yaml_linter'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe 'LicenseLint' do 
  describe '#do_lint' do 
    it 'displays error messages if there is no LICENSE.md file' do
      lint = YamlLint.new(FIXTURES_PATH + 'missing_license') 
      expect(lint.do_lint).to eq 0 
    end

    it 'displays error messages if license file has invalid content' do 
      lint = YamlLint.new(FIXTURES_PATH + 'bad_license')
      expect(lint.do_lint).to eq 0
    end

    it 'approves directory that has valid LICENSE.md' do
      lint = LicenseLinter.new(FIXTURES_PATH + 'good_license')
      expect(lint.do_lint).to eq 1 
    end
  end
end
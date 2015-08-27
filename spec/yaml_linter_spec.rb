require 'spec_helper'
require_relative '../lib/yaml_linter'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe 'YamlLint' do
  describe '.do_lint' do

    it 'displays errors when .learn is not valid yaml' do 
      lint = YamlLint.new(FIXTURES_PATH + 'bad_yaml')
      expect(lint.do_lint).to eq 0
    end
    it 'approves a directory with a valid .learn file' do
      lint = YamlLint.new(FIXTURES_PATH + 'good_learn')
      expect(lint.do_lint).to eq 0
    end

    it 'displays errors with an invalid .learn file' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad_learn')
      expect(lint.do_lint).to eq 1
    end

    it 'displays errors with a missing .learn file' do

      lint = YamlLint.new(FIXTURES_PATH + 'missing_learn')
      expect(lint.do_lint).to be > 0
    end
  end
end

#   describe 'validate_whitespace_for_learn' do
#     it 'is valid with two whitespaces before every attribute' do
#       file = FIXTURES_PATH + 'learn.yaml' 
#       lint = YamlLint.new(file)
#       expect(lint.validate_whitespace_for_learn(file)).to be true
#     end 

#     it 'is invalid with four whitespaces before every attribute' do 
#       file = FIXTURES_PATH + 'bad_learn.yaml'
#       lint = YamlLint.new(file)
#       expect(lint.validate_whitespace_for_learn(file)).to be false
#     end
#   end

#   describe 'the logging' do
#     it 'writes OK and error when not quiet' do
#       lint = YamlLint.new(FIXTURES_PATH)
#       expect { lint.do_lint }.to output(/Syntax OK/).to_stdout
#       expect { lint.do_lint }.to output(/error/).to_stdout
#     end

#     it 'does write only errors when quiet' do
#       lint = YamlLint.new(FIXTURES_PATH, {:quiet => true})
#       expect { lint.do_lint }.to_not output(/Syntax OK/).to_stdout
#       expect { lint.do_lint }.to output(/error/).to_stdout
#     end

#     it 'does not write anything when very quiet' do
#       lint = YamlLint.new(FIXTURES_PATH, {:veryquiet => true})
#       expect { lint.do_lint }.to_not output(/Syntax OK/).to_stdout
#       expect { lint.do_lint }.to_not output(/error/).to_stdout
#     end
#   end

#   describe 'with different file extensions' do

#     it 'is okay with known extensions' do
#       lint = YamlLint.new(FIXTURES_PATH + 'good.yaml')
#       expect(lint.do_lint).to eq 0
#       lint = YamlLint.new(FIXTURES_PATH + 'good.yml')
#       expect(lint.do_lint).to eq 0
#     end

#     it 'is not okay with an unknown extensions' do
#       lint = YamlLint.new(FIXTURES_PATH + 'good.lmay')
#       expect(lint.do_lint).to eq 1
#     end

#     it 'is okay with an unknown extensions when the extension is not checked' do
#       lint = YamlLint.new(FIXTURES_PATH + 'good.lmay', {:nocheckfileext => true})
#       expect(lint.do_lint).to eq 0
#     end
#   end
# end

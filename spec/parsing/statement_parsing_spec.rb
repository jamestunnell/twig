require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::StatementParser do
  before :each do
    @p = Parsing::StatementParser.new
  end

  context 'valid assignment' do
    it 'should parse' do
      ASSIGNMENT_STRS.each do |str|
      end
    end
  end

  context 'valid expression' do
    it 'should parse' do
      EXPRESSION_STRS.each do |str|
      end
    end
  end
end

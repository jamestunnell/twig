require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::ExpressionParser do
  before :each do
    @p = Parsing::ExpressionParser.new
  end
  
  context 'given a valid literal string' do
    it 'should parse' do
      LITERAL_STRS.each {|s| expect(@p.parse(s)).to_not be_nil }
    end
  end
  
  context 'given a valid identifier string' do
    it 'should parse' do
      IDENTIFIER_STRS.each {|s| expect(@p.parse(s)).to_not be_nil }
    end
  end
end

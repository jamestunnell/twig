require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::LiteralParser do
  before :each do
    @p = Parsing::LiteralParser.new
  end
  
  context 'given a valid string string' do
    it 'should parse' do
      RANDOM_ASCII_STRS.each {|s| expect(@p.parse(s)).to_not be_nil }
    end
  end
  
  context 'given a valid integer string' do
    it 'should parse' do
      RANDOM_INT_STRS.each {|s| expect(@p.parse(s)).to_not be_nil }
    end
  end
end

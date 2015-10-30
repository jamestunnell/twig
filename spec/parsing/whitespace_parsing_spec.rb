require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::WhitespaceParser do
  before :each do
    @p = Parsing::WhitespaceParser.new
  end
  
  context 'any whitespace character' do
    it 'should parse' do
      [" ","\t","\r","\n"].each {|ch| expect(@p.parse(ch)).to_not be nil }
    end
  end
end

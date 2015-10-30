require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::StringParser do
  before :each do
    @p = Parsing::StringParser.new
  end

  context 'string begins with double quote' do
    context 'string ends with double quote' do
      context 'string contains double quote(s) in between' do
        it 'should not parse' do
          RANDOM_ASCII_STRS.each do |str|
            idx = rand(1...(str.size-1))
            ch = str[idx]
            expect(@p.parse(str.gsub(ch,'"'))).to be_nil
          end
        end
      end
      
      context 'string contains no double quote in between' do
        it 'should parse' do
          RANDOM_ASCII_STRS.each do |str|
            expect(@p.parse(str)).to_not be_nil
          end          
        end
      end
    end
  end
end

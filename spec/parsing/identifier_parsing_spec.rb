require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::IdentifierParser do
  before :each do
    @p = Parsing::IdentifierParser.new
    @valid_tail_strs = ["abc","Abc","_b123","2_BAT__"]
  end
  
  context 'a single letter' do
    it 'should parse' do
      UPCASE_LETTERS.each {|ch| expect(@p.parse(ch)).to_not be nil }
      DOWNCASE_LETTERS.each {|ch| expect(@p.parse(ch)).to_not be nil }
    end
  end
  
  context 'a single underscore' do
    it 'should parse' do
      expect(@p.parse("_")).to_not be nil
    end
  end
  
  context 'a single digit' do
    it 'should not parse' do
      NUMERALS.each {|ch| expect(@p.parse(ch)).to be nil }
    end
  end
  
  context 'a wierd char' do
    it 'should not parse' do
      WIERD_CHARS.each {|ch| expect(@p.parse(ch)).to be nil }
    end
  end
  
  context 'a short string' do
    context 'starts with a letter' do
      context 'remaining chars are valid' do
        it 'should parse' do
          @valid_tail_strs.each do |tail_str|
            UPCASE_LETTERS.each {|ch| expect(@p.parse(ch+tail_str)).to_not be nil }
            DOWNCASE_LETTERS.each {|ch| expect(@p.parse(ch+tail_str)).to_not be nil }
          end
        end
      end
      
      context 'contains a wierd char' do
        it 'should not parse' do
          WIERD_CHARS.each do |wierd_ch|
            tail_str = "Abc" + wierd_ch + "123"
            UPCASE_LETTERS.each {|ch| expect(@p.parse(ch+tail_str)).to be nil }
            DOWNCASE_LETTERS.each {|ch| expect(@p.parse(ch+tail_str)).to be nil }
          end
        end
      end
    end
    
    context 'starts with an underscore' do
      context 'remaining chars are valid' do
        it 'should parse' do
          @valid_tail_strs.each do |tail_str|
            expect(@p.parse("_"+tail_str)).to_not be nil
          end
        end
      end
      
      context 'contains a wierd char' do
        it 'should not parse' do
          WIERD_CHARS.each do |wierd_ch|
            tail_str = "Abc" + wierd_ch + "123"
            expect(@p.parse("_"+tail_str)).to be nil
          end
        end
      end
    end
          
    context 'starts with a numeral' do
      context 'remaining chars are valid' do
        it 'should not parse' do
          NUMERALS.each do |ch|
            @valid_tail_strs.each do |tail_str|
              expect(@p.parse(ch+tail_str)).to be nil
            end
          end
        end
      end
    end
    
    context 'starts with an wierd char' do
      context 'remaining chars are valid' do
        it 'should not parse' do
          WIERD_CHARS.each do |ch|
            @valid_tail_strs.each do |tail_str|
              expect(@p.parse(ch+tail_str)).to be nil
            end
          end
        end
      end
    end
  end
end

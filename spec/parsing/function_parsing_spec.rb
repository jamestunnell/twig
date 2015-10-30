require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::FunctionParser do
  before :each do
    @p = Parsing::FunctionParser.new
  end
  
  context 'standard (named) function' do
    it 'should parse' do
      str = "function abc_123(x,y,z){
        
      }"
      expect(@p.parse(str)).to_not be_nil
    end
  end
  
  context 'anonymous function' do
    it 'should parse' do
      str = "function(x,y,z){
        
      }"
      expect(@p.parse(str)).to_not be_nil
    end
  end
  
  context 'no-param function' do
    it 'should parse' do
      str = "function abc_123(){
        
      }"
      expect(@p.parse(str)).to_not be_nil
    end    
  end
  
  context 'one-param function' do
    it 'should parse' do
      str = "function abc_123(x){
        
      }"
      expect(@p.parse(str)).to_not be_nil
    end 
  end
  
  context 'multi-param function' do
    it 'should parse' do
      str = 'function abc_123(name="joe", age = 22, birthday, height, etc){
        
      }'
      expect(@p.parse(str)).to_not be_nil
    end 
  end
end

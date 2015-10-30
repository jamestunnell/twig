require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::ExpressionParser do
  before :each do
    @p = Parsing::ExpressionParser.new
  end
  
  it 'should parse a valid literal string' do
    LITERAL_STRS.each {|s| expect(@p.parse(s)).to_not be_nil }
  end
  
  it 'should parse a valid identifier string' do
    IDENTIFIER_STRS.each {|s| expect(@p.parse(s)).to_not be_nil }
  end
  
  it 'should parse plain function calls' do
    [
      'myfunc()',
      'do_xyz(1,2,3)',
      'contact("bob",phone=1234567,email="bobbyboy@gogo.com")',
    ].each do |str|
      expect(@p.parse(str)).to_not be_nil
    end
  end
  
  it 'should parse plain method calls' do
    [
      'abc.myfunc()',
      'hey_you.do_xyz(1,2,3)',
      'please.contact("bob",phone=1234567,email="bobbyboy@gogo.com")',
    ].each do |str|
      expect(@p.parse(str)).to_not be_nil
    end
  end
  
  it 'should parse a function call chain' do
    [ 'please("john").do("my laundry").then("fold it")',
      'run("over here").then_add(123, 456)'
    ].each do |str|
      expect(@p.parse(str)).to_not be_nil
    end
  end
  
  it 'should parse a method call chain' do
    [ 'pretty.please("john").do("my laundry").then("fold it")',
      'you.run("over here").then_add(123, 456)'
    ].each do |str|
      expect(@p.parse(str)).to_not be_nil
    end
  end
  
  context 'a grouped expression' do
    it 'should parse' do
      [ '(hey.you("over there"))','(123)','("hello")'
      ].each do |str|
        expect(@p.parse(str)).to_not be_nil
      end
    end
  end
end

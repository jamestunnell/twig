require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::AssignmentParser do
  before :each do
    @p = Parsing::AssignmentParser.new
  end

  context 'valid assignment string' do
    it 'should parse' do
      ASSIGNMENT_STRS.each do |str|
        expect(@p.parse(str)).to_not be_nil
      end
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::ParamsParser do
  before :each do
    @p = Parsing::ParamsParser.new
  end
  
  context 'single identifier' do
    it 'should parse' do
      IDENTIFIER_STRS.each do |str|
        expect(@p.parse(str)).to_not be_nil
      end
    end
    
    context 'with valid expression for default value' do
      it 'should parse' do
        EXPRESSION_STRS.each do |expr_str|
          str = "joe = " + expr_str
          expect(@p.parse(str)).to_not be_nil
        end
      end
    end
  end
  
  context 'comma separated list of identifiers' do
    it 'should parse' do
      [ "a,b,c", "frank, bob", "__okay__  ,  dokey2, doo"].each do |str|
        expect(@p.parse(str)).to_not be_nil
      end
    end
    
    context 'with valid expressions for default values' do
      it 'should parse' do
        10.times do
          ids = IDENTIFIER_STRS.sample(rand(1..5))
          n_def_vals = rand(1..ids.size)
          def_val_flags = ([true]*n_def_vals + [false]*(ids.size-n_def_vals)).shuffle
          def_vals = Array.new(ids.size) do |i|
            def_val_flags[i] ? EXPRESSION_STRS.sample : nil
          end
          id_vals = Hash[ [ids,def_vals].transpose ]
          str = id_vals.map do |id,def_val|
            def_val.nil? ? id : (id + " = " + def_val)
          end.join(", ")
          expect(@p.parse(str)).to_not be_nil
        end
      end
    end
  end
end

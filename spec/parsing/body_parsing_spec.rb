require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::BodyParser do
  before :each do
    @p = Parsing::BodyParser.new
  end

  context 'single statement' do
    context 'by itself' do
      it 'should parse' do
        STATEMENT_STRS.sample(5).each do |str|
          expect(@p.parse(str)).to_not be_nil
        end
      end
    end

    context 'followed by non-newline whitespace only' do
      it 'should not parse' do
        STATEMENT_STRS.sample(5).each do |statement_str|
          ws_str = WHITESPACE_CHARS.sample(4).join("").gsub("\n","")
          str = statement_str + ws_str
          expect(@p.parse(str)).to be_nil
        end
      end
    end

    context 'followed by non-newline whitespace and then a semicolon' do
      it 'should parse' do
        STATEMENT_STRS.sample(5).each do |statement_str|
          ws_str = WHITESPACE_CHARS.sample(4).join("").gsub("\n","")
          str = statement_str + ws_str + ";"
          expect(@p.parse(str)).to_not be_nil
        end
      end
    end

    context 'followed by non-newline whitespace and then a newline' do
      it 'should parse' do
        STATEMENT_STRS.sample(5).each do |statement_str|
          ws_str = WHITESPACE_CHARS.sample(4).join("").gsub("\n","")
          str = statement_str + ws_str + "\n"
          expect(@p.parse(str)).to_not be_nil
        end
      end
    end
  end

  context 'multiple statements' do
    context 'separated by newlines only' do
      it 'should parse' do
        str = STATEMENT_STRS.sample(5).join("\n")
        expect(@p.parse(str)).to_not be_nil
      end
    end

    context 'separated by semicolons only' do
      it 'should parse' do
        str = STATEMENT_STRS.sample(5).join(";")
        expect(@p.parse(str)).to_not be_nil
      end
    end

    context 'separated by whitespace and multiple semicolons and/or newlines' do
      it 'should parse' do
        5.times do
          strs = STATEMENT_STRS.sample(5).map do |statement_str|
            delim_str = (WHITESPACE_CHARS.sample(rand(2..10)) + [";","\n"].sample(rand(2..10))).shuffle.join("")
            statement_str + delim_str
          end.join("")
          str = strs + STATEMENT_STRS.sample
          expect(@p.parse(str)).to_not be_nil
        end
      end
    end
  end
end

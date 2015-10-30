require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parsing::IntegerParser do
  before :each do
    @p = Parsing::IntegerParser.new
  end

  {
    '' => 'no',
    '-' => 'minus',
    '+' => 'plus'
  }.each do |sign, sign_name|
    context "starts with #{sign_name} sign" do

      digit_setup = {
        :bin => {
          :prefixes => ['0b','0B'],
          :digit_strs => BIN_DIGIT_STRS,
          :digits_strs_parses => {
            :bin => true, :hex => false, :dec => false
          }
        },
        :hex => {
          :prefixes => ['0x','0X'],
          :digit_strs => HEX_DIGIT_STRS,
          :digits_strs_parses => {
            :bin => true, :hex => true, :dec => true
          }
        },
        :dec => {
          :prefixes => [''],
          :digit_strs => DEC_DIGIT_STRS,
          :digits_strs_parses => {
            :bin => true, :hex => false, :dec => true
          }
        } 
      }

      [ :bin, :hex, :dec ].each do |digit_type|
        context "followed by #{digit_type} prefix" do
          digit_setup[digit_type][:prefixes].each do |prefix|
            [ :bin, :hex, :dec ].each do |digit_strs_type|
              context "followed by #{digit_strs_type} digits" do
                parses = digit_setup[digit_type][:digits_strs_parses][digit_strs_type]
                it "should#{parses ? "" : " not"} parse" do
                  digit_setup[digit_strs_type][:digit_strs].each do |digits_str|
                    str = sign+prefix+digits_str
                    parsed = !@p.parse(str).nil?
                    expect(parsed).to eq(parses)
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  # context 'integer begins with minus sign' do
  #   context 'followed by bin prefix' do
  #     context 'followed by bin digits' do
  #       it 'should parse' do
  #         ["-0b","-0B"].each do |prefix|
  #           BIN_DIGIT_STRS.each do |digits_str|
  #             expect(@p.parse(prefix+digits_str)).to_not be_nil
  #           end
  #         end
  #       end
  #     end

  #     context 'followed by hex digits' do
  #       it 'should not parse' do
  #         ["-0b","-0B"].each do |prefix|
  #           HEX_DIGIT_STRS.each do |digits_str|
  #             expect(@p.parse(prefix+digits_str)).to be_nil
  #           end
  #         end
  #       end
  #     end

  #     context 'followed by dec digits' do
  #       it 'should not parse' do
  #         ["-0b","-0B"].each do |prefix|
  #           DEC_DIGIT_STRS.each do |digits_str|
  #             expect(@p.parse(prefix+digits_str)).to be_nil
  #           end
  #         end
  #       end
  #     end
  #   end

  #   context 'followed by hex prefix' do
  #     context 'followed by bin digits' do
  #       it 'should parse' do
  #         expect(@p.parse("-0x011001011")).to_not be_nil
  #         expect(@p.parse("-0X011001011")).to_not be_nil
  #       end
  #     end

  #     context 'followed by hex digits' do
  #       it 'should parse' do
  #         expect(@p.parse("-0x123456ABC")).to_not be_nil
  #         expect(@p.parse("-0X123456ABC")).to_not be_nil
  #       end
  #     end

  #     context 'followed by dec digits' do
  #       it 'should parse' do
  #         expect(@p.parse("-0x123456789")).to_not be_nil
  #         expect(@p.parse("-0X123456789")).to_not be_nil
  #       end
  #     end
  #   end

  #   context 'followed by bin digits' do
  #     it 'should parse' do
  #       expect(@p.parse("-011001011")).to_not be_nil
  #       expect(@p.parse("-011001011")).to_not be_nil
  #     end
  #   end

  #   context 'followed by hex digits' do
  #     it 'should not parse' do
  #       expect(@p.parse("-123456ABC")).to be_nil
  #       expect(@p.parse("-123456ABC")).to be_nil
  #     end
  #   end

  #   context 'followed by dec digits' do
  #     it 'should parse' do
  #       expect(@p.parse("-123456789")).to_not be_nil
  #       expect(@p.parse("-123456789")).to_not be_nil
  #     end
  #   end
  # end

  # context 'integer begins with plus sign' do
  #   context 'followed by bin prefix' do
  #     context 'followed by bin digits' do
  #       it 'should parse' do
  #         expect(@p.parse("+0b011001011")).to_not be_nil
  #         expect(@p.parse("+0B011001011")).to_not be_nil
  #       end
  #     end

  #     context 'followed by hex digits' do
  #       it 'should not parse' do
  #         expect(@p.parse("+0b123456ABC")).to be_nil
  #         expect(@p.parse("+0B123456ABC")).to be_nil
  #       end
  #     end

  #     context 'followed by dec digits' do
  #       it 'should not parse' do
  #         expect(@p.parse("+0b123456789")).to be_nil
  #         expect(@p.parse("+0B123456789")).to be_nil
  #       end
  #     end
  #   end

  #   context 'followed by hex prefix' do
  #     context 'followed by bin digits' do
  #       it 'should parse' do
  #         expect(@p.parse("+0x011001011")).to_not be_nil
  #         expect(@p.parse("+0X011001011")).to_not be_nil
  #       end
  #     end

  #     context 'followed by hex digits' do
  #       it 'should parse' do
  #         expect(@p.parse("+0x123456ABC")).to_not be_nil
  #         expect(@p.parse("+0X123456ABC")).to_not be_nil
  #       end
  #     end

  #     context 'followed by dec digits' do
  #       it 'should parse' do
  #         expect(@p.parse("+0x123456789")).to_not be_nil
  #         expect(@p.parse("+0X123456789")).to_not be_nil
  #       end
  #     end
  #   end

  #   context 'followed by bin digits' do
  #     it 'should parse' do
  #       expect(@p.parse("+011001011")).to_not be_nil
  #       expect(@p.parse("+011001011")).to_not be_nil
  #     end
  #   end

  #   context 'followed by hex digits' do
  #     it 'should not parse' do
  #       expect(@p.parse("+123456ABC")).to be_nil
  #       expect(@p.parse("+123456ABC")).to be_nil
  #     end
  #   end

  #   context 'followed by dec digits' do
  #     it 'should parse' do
  #       expect(@p.parse("+123456789")).to_not be_nil
  #       expect(@p.parse("+123456789")).to_not be_nil
  #     end
  #   end
  # end

  # context 'integer begins with bin prefix' do
  #   context 'followed by bin digits' do
  #     it 'should parse' do
  #       expect(@p.parse("0b011001011")).to_not be_nil
  #       expect(@p.parse("0B011001011")).to_not be_nil
  #     end
  #   end

  #   context 'followed by hex digits' do
  #     it 'should not parse' do
  #       expect(@p.parse("0b123456ABC")).to be_nil
  #       expect(@p.parse("0B123456ABC")).to be_nil
  #     end
  #   end

  #   context 'followed by dec digits' do
  #     it 'should not parse' do
  #       expect(@p.parse("0b123456789")).to be_nil
  #       expect(@p.parse("0B123456789")).to be_nil
  #     end
  #   end
  # end

  # context 'integer begins with hex prefix' do
  #   context 'followed by bin digits' do
  #     it 'should parse' do
  #       expect(@p.parse("0x011001011")).to_not be_nil
  #       expect(@p.parse("0X011001011")).to_not be_nil
  #     end
  #   end

  #   context 'followed by hex digits' do
  #     it 'should parse' do
  #       expect(@p.parse("0x123456ABC")).to_not be_nil
  #       expect(@p.parse("0X123456ABC")).to_not be_nil
  #     end
  #   end

  #   context 'followed by dec digits' do
  #     it 'should parse' do
  #       expect(@p.parse("0x123456789")).to_not be_nil
  #       expect(@p.parse("0X123456789")).to_not be_nil
  #     end
  #   end
  # end

  # context 'integer contains only bin digits' do
  #   it 'should parse' do
  #     expect(@p.parse("011001011")).to_not be_nil
  #     expect(@p.parse("011001011")).to_not be_nil
  #   end
  # end

  # context 'integer contains only hex digits' do
  #   it 'should not parse' do
  #     expect(@p.parse("123456ABC")).to be_nil
  #     expect(@p.parse("123456ABC")).to be_nil
  #   end
  # end

  # context 'integer contains only dec digits' do
  #   it 'should parse' do
  #     expect(@p.parse("123456789")).to_not be_nil
  #     expect(@p.parse("123456789")).to_not be_nil
  #   end
  # end
end

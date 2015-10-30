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
end

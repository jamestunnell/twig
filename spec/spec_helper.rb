require 'rspec'
require 'twig'

include Twig

UPCASE_LETTERS = [
  "A","B","C","D","E","F","G","H","I","J","K","L","M",
  "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
]
                   
DOWNCASE_LETTERS = UPCASE_LETTERS.map do |l|
  l.downcase
end

NUMERALS = [ "1","2","3","4","5","6","7","8","9" ]
WIERD_CHARS = [ "*","(","&",",",".","<",">","?","#","@" ]

BIN_DIGIT_STRS = [
  "0100011", "1011101100", "01000101011", "1011"
]

HEX_DIGIT_STRS = [
  "FFFF", "ffff", "123ABC", "123abc", "def456", "DEF456"
]

DEC_DIGIT_STRS = [
  "123456789", "545512", "222135", "8390811", "021209593"
]
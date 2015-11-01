require 'rspec'
require 'twig'

include Twig

WHITESPACE_CHARS = [" ","\t","\r","\n"]

UPCASE_LETTERS = [
  "A","B","C","D","E","F","G","H","I","J","K","L","M",
  "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
]
                   
DOWNCASE_LETTERS = UPCASE_LETTERS.map do |l|
  l.downcase
end

NUMERALS = [ "1","2","3","4","5","6","7","8","9" ]
WIERD_CHARS = [ "*","(","&",",",".","<",">","?","#","@" ]

IDENTIFIER_STRS = [
  "WuLw65Y7PUJJl", "iBVHaB1DTI8Pt81p", "gKOfLmzXT", "OKKCPEK8ngnFLv6", "_TbD8",
  "x5UtEu6", "aLYiqnQMJR", "PpxC4w", "L_pjD", "dZVRwfeZ", "B7como3UPfNL6", "fGa7u1hC_dG941"
]

BIN_DIGIT_STRS = [
  "0100011", "1011101100", "01000101011", "1011"
]

HEX_DIGIT_STRS = [
  "FFFF", "ffff", "123ABC", "123abc", "def456", "DEF456"
]

DEC_DIGIT_STRS = [
  "123456789", "545512", "222135", "8390811", "021209593"
]

RANDOM_INT_STRS = [
  BIN_DIGIT_STRS.map {|s| "0b" + s },
  HEX_DIGIT_STRS.map {|s| "0x" + s },
  DEC_DIGIT_STRS
].flatten

RANDOM_ASCII_STRS = [
  '"xOK`SvSYBUKRBrhzfT"', '"zUc~UPEMizt\\JV~smzB"', '"{PH`rI[P"', '"_H\\kC"',
  '"szKADA]Feq]Hw"', '"]zlXYyXh}"', '"Au]\\lMJMOXz^}U{D}"',
  '"zSVUf^fH}^fTAQr~tZTHFB"', '"jmGuph|QLeEqAZf[RvD_]]"', '"{TfJbj|_WXHQgsnndQq"'
]

LITERAL_STRS = RANDOM_INT_STRS + RANDOM_ASCII_STRS
EXPRESSION_STRS = LITERAL_STRS + IDENTIFIER_STRS

ASSIGNMENT_STRS = [ 
  "WuLw65Y7PUJJl \n=\n 123456789", "dZVRwfe\n  = 0b1011", 
  "aLYiqnQMJR   =\n \"zUc~UPEMizt\JV~smzB\"",
  "B7como3UPfNL6= iBVHaB1DTI8Pt81p",
  "x5UtEu6=\"Au]\lMJMOXz^}U{D}\"",
  "iBVHaB1DTI8Pt81p\n  =0b1011"
]

STATEMENT_STRS = EXPRESSION_STRS + ASSIGNMENT_STRS
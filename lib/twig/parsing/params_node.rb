module Twig
module Parsing
  class ArgsNode < Treetop::Runtime::SyntaxNode
    def args
      text_value.split(",")
    end
  end
end
end
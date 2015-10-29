module Twig
module Parsing
  class FunctionNode < Treetop::Runtime::SyntaxNode
    def name
      id.empty? ? "" : id.identifier.text_value
    end

    def args
      if fargs.empty?
        return []
      else
        fargs.args
      end
    end
  end
end
end
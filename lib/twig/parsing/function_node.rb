module Twig
module Parsing
  class FunctionNode < Treetop::Runtime::SyntaxNode
    def name
      id.empty? ? "" : id.identifier.text_value
    end

    def params
      if fparams.empty?
        return []
      else
        fparams.params
      end
    end
  end
end
end
module Twig
module Parsing
  class ParamsNode < Treetop::Runtime::SyntaxNode
    def params
      ps = [first]
      unless more.empty?
        ps += more.elements.map {|x| x.param }
      end
      return ps
    end
  end
  
  class ParamNode < Treetop::Runtime::SyntaxNode
    def identifier
      identifier.text_value
    end
    
    def default_value
      default_val.empty? ? nil : default_val.text_value
    end
  end
end
end
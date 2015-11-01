# Autogenerated from a Treetop grammar. Edits may be lost.


module Twig
module Parsing

module Statement
  include Treetop::Runtime

  def root
    @root ||= :statement
  end

  include Assignment

  include Expression

  def _nt_statement
    start_index = index
    if node_cache[:statement].has_key?(index)
      cached = node_cache[:statement][index]
      if cached
        node_cache[:statement][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_assignment
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_expression
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:statement][start_index] = r0

    r0
  end

end

class StatementParser < Treetop::Runtime::CompiledParser
  include Statement
end


end
end
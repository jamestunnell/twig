# Autogenerated from a Treetop grammar. Edits may be lost.


module Twig
module Parsing

module Expression
  include Treetop::Runtime

  def root
    @root ||= :expression
  end

  include Identifier

  include Literal

  include Whitespace

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      if cached
        node_cache[:expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_method_call
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_call_chain
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_grouped_expression
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          r4 = _nt_identifier
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
          else
            r5 = _nt_literal
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
            else
              @index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:expression][start_index] = r0

    r0
  end

  module MethodCall0
    def reciever
      elements[0]
    end

    def call_chain
      elements[2]
    end
  end

  def _nt_method_call
    start_index = index
    if node_cache[:method_call].has_key?(index)
      cached = node_cache[:method_call][index]
      if cached
        node_cache[:method_call][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    r2 = _nt_grouped_expression
    if r2
      r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
      r1 = r2
    else
      r3 = _nt_identifier
      if r3
        r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
        r1 = r3
      else
        r4 = _nt_literal
        if r4
          r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
          r1 = r4
        else
          @index = i1
          r1 = nil
        end
      end
    end
    s0 << r1
    if r1
      if (match_len = has_terminal?(".", false, index))
        r5 = true
        @index += match_len
      else
        terminal_parse_failure('"."')
        r5 = nil
      end
      s0 << r5
      if r5
        r6 = _nt_call_chain
        s0 << r6
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(MethodCall0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:method_call][start_index] = r0

    r0
  end

  module CallChain0
    def call
      elements[1]
    end
  end

  module CallChain1
    def first
      elements[0]
    end

    def more
      elements[1]
    end
  end

  def _nt_call_chain
    start_index = index
    if node_cache[:call_chain].has_key?(index)
      cached = node_cache[:call_chain][index]
      if cached
        node_cache[:call_chain][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_call
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        if (match_len = has_terminal?(".", false, index))
          r4 = true
          @index += match_len
        else
          terminal_parse_failure('"."')
          r4 = nil
        end
        s3 << r4
        if r4
          r5 = _nt_call
          s3 << r5
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(CallChain0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(CallChain1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:call_chain][start_index] = r0

    r0
  end

  module Call0
    def another
      elements[3]
    end
  end

  module Call1
    def first
      elements[0]
    end

    def more
      elements[1]
    end
  end

  module Call2
    def identifier
      elements[0]
    end

    def args
      elements[3]
    end

  end

  def _nt_call
    start_index = index
    if node_cache[:call].has_key?(index)
      cached = node_cache[:call][index]
      if cached
        node_cache[:call][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_identifier
    s0 << r1
    if r1
      if (match_len = has_terminal?("(", false, index))
        r2 = true
        @index += match_len
      else
        terminal_parse_failure('"("')
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          r4 = _nt_ws
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        s0 << r3
        if r3
          i6, s6 = index, []
          r7 = _nt_arg
          s6 << r7
          if r7
            s8, i8 = [], index
            loop do
              i9, s9 = index, []
              s10, i10 = [], index
              loop do
                r11 = _nt_ws
                if r11
                  s10 << r11
                else
                  break
                end
              end
              r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
              s9 << r10
              if r10
                if (match_len = has_terminal?(",", false, index))
                  r12 = true
                  @index += match_len
                else
                  terminal_parse_failure('","')
                  r12 = nil
                end
                s9 << r12
                if r12
                  s13, i13 = [], index
                  loop do
                    r14 = _nt_ws
                    if r14
                      s13 << r14
                    else
                      break
                    end
                  end
                  r13 = instantiate_node(SyntaxNode,input, i13...index, s13)
                  s9 << r13
                  if r13
                    r15 = _nt_arg
                    s9 << r15
                  end
                end
              end
              if s9.last
                r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
                r9.extend(Call0)
              else
                @index = i9
                r9 = nil
              end
              if r9
                s8 << r9
              else
                break
              end
            end
            r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
            s6 << r8
          end
          if s6.last
            r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
            r6.extend(Call1)
          else
            @index = i6
            r6 = nil
          end
          if r6
            r5 = r6
          else
            r5 = instantiate_node(SyntaxNode,input, index...index)
          end
          s0 << r5
          if r5
            s16, i16 = [], index
            loop do
              r17 = _nt_ws
              if r17
                s16 << r17
              else
                break
              end
            end
            r16 = instantiate_node(SyntaxNode,input, i16...index, s16)
            s0 << r16
            if r16
              if (match_len = has_terminal?(")", false, index))
                r18 = true
                @index += match_len
              else
                terminal_parse_failure('")"')
                r18 = nil
              end
              s0 << r18
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Call2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:call][start_index] = r0

    r0
  end

  module Arg0
    def identifier
      elements[0]
    end

  end

  module Arg1
    def param_name
      elements[0]
    end

    def expression
      elements[1]
    end
  end

  def _nt_arg
    start_index = index
    if node_cache[:arg].has_key?(index)
      cached = node_cache[:arg][index]
      if cached
        node_cache[:arg][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    r3 = _nt_identifier
    s2 << r3
    if r3
      s4, i4 = [], index
      loop do
        r5 = _nt_ws
        if r5
          s4 << r5
        else
          break
        end
      end
      r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
      s2 << r4
      if r4
        if (match_len = has_terminal?("=", false, index))
          r6 = true
          @index += match_len
        else
          terminal_parse_failure('"="')
          r6 = nil
        end
        s2 << r6
        if r6
          s7, i7 = [], index
          loop do
            r8 = _nt_ws
            if r8
              s7 << r8
            else
              break
            end
          end
          r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
          s2 << r7
        end
      end
    end
    if s2.last
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      r2.extend(Arg0)
    else
      @index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      r9 = _nt_expression
      s0 << r9
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Arg1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:arg][start_index] = r0

    r0
  end

  module GroupedExpression0
    def expression
      elements[2]
    end

  end

  def _nt_grouped_expression
    start_index = index
    if node_cache[:grouped_expression].has_key?(index)
      cached = node_cache[:grouped_expression][index]
      if cached
        node_cache[:grouped_expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("(", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"("')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        r3 = _nt_ws
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        r4 = _nt_expression
        s0 << r4
        if r4
          s5, i5 = [], index
          loop do
            r6 = _nt_ws
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          s0 << r5
          if r5
            if (match_len = has_terminal?(")", false, index))
              r7 = true
              @index += match_len
            else
              terminal_parse_failure('")"')
              r7 = nil
            end
            s0 << r7
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(GroupedExpression0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:grouped_expression][start_index] = r0

    r0
  end

end

class ExpressionParser < Treetop::Runtime::CompiledParser
  include Expression
end


end
end
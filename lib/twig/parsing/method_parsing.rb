# Autogenerated from a Treetop grammar. Edits may be lost.


module Twig
module Parsing

module Method
  include Treetop::Runtime

  def root
    @root ||= :method
  end

  include Identifier

  include Params

  include Body

  module Method0
    def identifier
      elements[2]
    end

  end

  def _nt_method
    start_index = index
    if node_cache[:method].has_key?(index)
      cached = node_cache[:method][index]
      if cached
        node_cache[:method][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("method", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"method"')
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
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
      if r2
        r4 = _nt_identifier
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
            if (match_len = has_terminal?("(", false, index))
              r7 = true
              @index += match_len
            else
              terminal_parse_failure('"("')
              r7 = nil
            end
            s0 << r7
            if r7
              s8, i8 = [], index
              loop do
                r9 = _nt_ws
                if r9
                  s8 << r9
                else
                  break
                end
              end
              r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
              s0 << r8
              if r8
                r11 = _nt_params
                if r11
                  r10 = r11
                else
                  r10 = instantiate_node(SyntaxNode,input, index...index)
                end
                s0 << r10
                if r10
                  s12, i12 = [], index
                  loop do
                    r13 = _nt_ws
                    if r13
                      s12 << r13
                    else
                      break
                    end
                  end
                  r12 = instantiate_node(SyntaxNode,input, i12...index, s12)
                  s0 << r12
                  if r12
                    if (match_len = has_terminal?(")", false, index))
                      r14 = true
                      @index += match_len
                    else
                      terminal_parse_failure('")"')
                      r14 = nil
                    end
                    s0 << r14
                    if r14
                      s15, i15 = [], index
                      loop do
                        r16 = _nt_ws
                        if r16
                          s15 << r16
                        else
                          break
                        end
                      end
                      r15 = instantiate_node(SyntaxNode,input, i15...index, s15)
                      s0 << r15
                      if r15
                        if (match_len = has_terminal?("{", false, index))
                          r17 = true
                          @index += match_len
                        else
                          terminal_parse_failure('"{"')
                          r17 = nil
                        end
                        s0 << r17
                        if r17
                          s18, i18 = [], index
                          loop do
                            r19 = _nt_ws
                            if r19
                              s18 << r19
                            else
                              break
                            end
                          end
                          r18 = instantiate_node(SyntaxNode,input, i18...index, s18)
                          s0 << r18
                          if r18
                            r21 = _nt_body
                            if r21
                              r20 = r21
                            else
                              r20 = instantiate_node(SyntaxNode,input, index...index)
                            end
                            s0 << r20
                            if r20
                              s22, i22 = [], index
                              loop do
                                r23 = _nt_ws
                                if r23
                                  s22 << r23
                                else
                                  break
                                end
                              end
                              r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
                              s0 << r22
                              if r22
                                if (match_len = has_terminal?("}", false, index))
                                  r24 = true
                                  @index += match_len
                                else
                                  terminal_parse_failure('"}"')
                                  r24 = nil
                                end
                                s0 << r24
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
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Method0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:method][start_index] = r0

    r0
  end

end

class MethodParser < Treetop::Runtime::CompiledParser
  include Method
end


end
end
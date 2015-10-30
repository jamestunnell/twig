# Autogenerated from a Treetop grammar. Edits may be lost.


module Twig
module Parsing

module Integer
  include Treetop::Runtime

  def root
    @root ||= :integer
  end

  def _nt_integer
    start_index = index
    if node_cache[:integer].has_key?(index)
      cached = node_cache[:integer][index]
      if cached
        node_cache[:integer][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_bin_int
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_hex_int
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_dec_int
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:integer][start_index] = r0

    r0
  end

  module BinInt0
    def bin_prefix
      elements[1]
    end

  end

  module BinInt1
    def to_i
      text_value.to_i(2)
    end
  end

  def _nt_bin_int
    start_index = index
    if node_cache[:bin_int].has_key?(index)
      cached = node_cache[:bin_int][index]
      if cached
        node_cache[:bin_int][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r2 = _nt_sign
    if r2
      r1 = r2
    else
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      r3 = _nt_bin_prefix
      s0 << r3
      if r3
        s4, i4 = [], index
        loop do
          r5 = _nt_bin_digit
          if r5
            s4 << r5
          else
            break
          end
        end
        if s4.empty?
          @index = i4
          r4 = nil
        else
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        end
        s0 << r4
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(BinInt0)
      r0.extend(BinInt1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:bin_int][start_index] = r0

    r0
  end

  module HexInt0
    def hex_prefix
      elements[1]
    end

  end

  module HexInt1
    def to_i
      text_value.to_i(16)
    end
  end

  def _nt_hex_int
    start_index = index
    if node_cache[:hex_int].has_key?(index)
      cached = node_cache[:hex_int][index]
      if cached
        node_cache[:hex_int][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r2 = _nt_sign
    if r2
      r1 = r2
    else
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      r3 = _nt_hex_prefix
      s0 << r3
      if r3
        s4, i4 = [], index
        loop do
          r5 = _nt_hex_digit
          if r5
            s4 << r5
          else
            break
          end
        end
        if s4.empty?
          @index = i4
          r4 = nil
        else
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        end
        s0 << r4
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(HexInt0)
      r0.extend(HexInt1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:hex_int][start_index] = r0

    r0
  end

  module DecInt0
  end

  module DecInt1
    def to_i
      text_value.to_i(10)
    end
  end

  def _nt_dec_int
    start_index = index
    if node_cache[:dec_int].has_key?(index)
      cached = node_cache[:dec_int][index]
      if cached
        node_cache[:dec_int][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r2 = _nt_sign
    if r2
      r1 = r2
    else
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      s3, i3 = [], index
      loop do
        r4 = _nt_dec_digit
        if r4
          s3 << r4
        else
          break
        end
      end
      if s3.empty?
        @index = i3
        r3 = nil
      else
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      end
      s0 << r3
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(DecInt0)
      r0.extend(DecInt1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:dec_int][start_index] = r0

    r0
  end

  module BinPrefix0
  end

  def _nt_bin_prefix
    start_index = index
    if node_cache[:bin_prefix].has_key?(index)
      cached = node_cache[:bin_prefix][index]
      if cached
        node_cache[:bin_prefix][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("0", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"0"')
      r1 = nil
    end
    s0 << r1
    if r1
      if has_terminal?(@regexps[gr = '\A[Bb]'] ||= Regexp.new(gr), :regexp, index)
        r2 = true
        @index += 1
      else
        terminal_parse_failure('[Bb]')
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(BinPrefix0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:bin_prefix][start_index] = r0

    r0
  end

  def _nt_bin_digit
    start_index = index
    if node_cache[:bin_digit].has_key?(index)
      cached = node_cache[:bin_digit][index]
      if cached
        node_cache[:bin_digit][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if has_terminal?(@regexps[gr = '\A[0-1]'] ||= Regexp.new(gr), :regexp, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('[0-1]')
      r0 = nil
    end

    node_cache[:bin_digit][start_index] = r0

    r0
  end

  module HexPrefix0
  end

  def _nt_hex_prefix
    start_index = index
    if node_cache[:hex_prefix].has_key?(index)
      cached = node_cache[:hex_prefix][index]
      if cached
        node_cache[:hex_prefix][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("0", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"0"')
      r1 = nil
    end
    s0 << r1
    if r1
      if has_terminal?(@regexps[gr = '\A[Xx]'] ||= Regexp.new(gr), :regexp, index)
        r2 = true
        @index += 1
      else
        terminal_parse_failure('[Xx]')
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(HexPrefix0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:hex_prefix][start_index] = r0

    r0
  end

  def _nt_hex_digit
    start_index = index
    if node_cache[:hex_digit].has_key?(index)
      cached = node_cache[:hex_digit][index]
      if cached
        node_cache[:hex_digit][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if has_terminal?(@regexps[gr = '\A[0-9A-Fa-f]'] ||= Regexp.new(gr), :regexp, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('[0-9A-Fa-f]')
      r0 = nil
    end

    node_cache[:hex_digit][start_index] = r0

    r0
  end

  def _nt_dec_digit
    start_index = index
    if node_cache[:dec_digit].has_key?(index)
      cached = node_cache[:dec_digit][index]
      if cached
        node_cache[:dec_digit][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if has_terminal?(@regexps[gr = '\A[0-9]'] ||= Regexp.new(gr), :regexp, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('[0-9]')
      r0 = nil
    end

    node_cache[:dec_digit][start_index] = r0

    r0
  end

  def _nt_sign
    start_index = index
    if node_cache[:sign].has_key?(index)
      cached = node_cache[:sign][index]
      if cached
        node_cache[:sign][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?("+", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"+"')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      if (match_len = has_terminal?("-", false, index))
        r2 = true
        @index += match_len
      else
        terminal_parse_failure('"-"')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:sign][start_index] = r0

    r0
  end

end

class IntegerParser < Treetop::Runtime::CompiledParser
  include Integer
end


end
end
class Lit < Struct.new(:literal)
  def ==(other)
    eql?(other)
  end
  def eql?(other)
    other && (literal == other.literal)
  end
  def to_ruby
    literal.inspect
  end

  def inspect
    literal.inspect
  end
end

class Num < Lit; end

class Sym < Lit
  def to_ruby
    literal.to_s
  end
end

class Str < Lit; end

class Nil < Lit; end

class Var < Lit; end

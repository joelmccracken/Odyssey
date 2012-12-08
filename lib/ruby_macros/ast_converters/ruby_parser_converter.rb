require "ruby_parser"

class RubyParserConverter
end


def mparse code
  RubyParserASTDescriminator.new(code).translate
end

def domacros code
  RubyParserASTDescriminator.new(code).translate
end


class RubyParserASTDescriminator
  def initialize(code)
    @code = code
  end
  def parse
    ast = Ruby19Parser.new.parse @code
  end

  def translate
    # the root of every translation is a set of statements
    @statements = trans(parse) #Statements.new(trans(parse))
    self
  end

  def macros
    translate
    [ast].map do |m|
      m.find_macros
    end.reject(&:nil?)
  end

  def ast
    @statements
  end

  private
  def trans ast
    return nil if ast.nil?

    case ast.sexp_type
    when :lit then
      literal = ast[1]
      if literal.is_a?(Numeric)
        Num.new(literal)
      elsif literal.is_a?(Symbol)
        Sym.new(literal)
      end
    when :iter then
      message = trans(ast[1])

      lines_to_translate = ast[3..-1]
      new_lines = []
      lines_to_translate.each do |line|
        new_lines << trans(line)
      end

      message.block = Block.new trans(ast[2]),  new_lines
      message
    when :call then
      Message.new(trans(ast[1]), Sym.new(ast[2]), trans(ast[3]))
    when :str then
      Str.new(ast[1])
    when :args then
      if ast[1].nil? then
        nil
      else
        [ast[1]]
      end
    else raise "Untranslated Error: #{ast.inspect}"
    end
  end
end

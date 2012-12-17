require "ruby_parser"

class RubyParserConverter
  def initialize(code)
    @code = code
  end

  def parse
    ast = Ruby19Parser.new.parse @code
  end

  def translate
    # the root of every translation is a set of statements
    @statements = trans(parse)
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

  def statements
    @statements
  end

  private
  def trans ast
    return nil if ast.nil?

    case ast.sexp_type
    when :lit then
      ast[1]
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
      if ast[2] == :def_macro then
        MacroDef.new(trans(ast[3]), trans(ast[3]))
      else
        Message.new(trans(ast[1]), ast[2], trans(ast[3]))
      end
    when :str then
      ast[1]
    when :args then
      if ast[1].nil? then
        nil
      else
        [ast[1]]
      end
    when :block then
      ImplicitBlock.new(ast[1..-1].map do |it|
                          trans(it)
                        end)
    when :lvar then
      Var.new(ast[1])
    else raise "Untranslated Error: #{ast.inspect}"
    end
  end
end


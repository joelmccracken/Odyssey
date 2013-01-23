require "ruby_parser"

module Odyssey
  module Parsers
    class RubyParserConverter
      def initialize(ruby_parser_gem_parser)
        @ruby_parser_gem_parser = ruby_parser_gem_parser
      end

      def translate(code)
        @code = code
        # the root of every translation is a set of statements
        @statements = trans(@ruby_parser_gem_parser.parse @code)
        self
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
          if ast[2] == :defmacro then
            MacroDef.new(trans(ast[3]), trans(ast[3]))
          else
            args = ast[3..-1].map do |arg|
              trans(arg)
            end
            Message.new(trans(ast[1]), ast[2], args)
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
  end
end




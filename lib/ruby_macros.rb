require "ruby_macros/version"
require "ruby_macros/irb"
require "ruby_macros/macro_applyer"
require "ruby_macros/macro_finder"
require "ruby_macros/ast/block"
require "ruby_macros/ast/message"
require "ruby_macros/ast/implicit_block"
require "ruby_macros/ast/literals"
require "ruby_macros/ast/macro_def"
require "ruby_macros/ast_converters/ruby_parser_converter"

module RubyMacros
  def self.domacros code
    parsed = RubyParserASTDescriminator.new(code).translate
    mf = MacroFinder.new(MacroDef)
    ma = MacroApplyer.new(mf, Message)
    ma.apply(parsed)
  end

  def self.mparse code
    RubyParserASTDescriminator.new(code).translate
  end
end



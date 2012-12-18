require "odyssey/version"
require "odyssey/irb"
require "odyssey/macro_applyer"
require "odyssey/macro_finder"
require "odyssey/ast/block"
require "odyssey/ast/message"
require "odyssey/ast/implicit_block"
require "odyssey/ast/literals"
require "odyssey/ast/macro_def"
require "odyssey/parsers/ruby_parser_converter"
require "refine"

module Odyssey
  def self.domacros code
    parsed = Parsers::RubyParserConverter.new(code).translate
    mf = MacroFinder.new(MacroDef)
    ma = MacroApplyer.new(mf, Message)
    ma.apply(parsed)
  end

  def self.mparse code
    Parsers::RubyParserConverter.new(code).translate
  end

  # TODO support all of the possible options here
  def self.evaluator
    Evaluator.new()
  end

  class Evaluator
    def initialize()

    end

    def evaluate code
      parsed = RubyParserConverter.new(code).translate
      mf = MacroFinder.new(MacroDef)
      ma = MacroApplyer.new(mf, Message)
      ma.apply(parsed)
    end
  end
end


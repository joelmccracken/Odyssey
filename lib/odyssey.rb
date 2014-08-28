require "odyssey/version"
require "odyssey/irb"
require "odyssey/macro_applyer"
require "odyssey/macro_finder"
require "odyssey/to_ruby"
require "odyssey/ast/block"
require "odyssey/ast/message"
require "odyssey/ast/implicit_block"
require "odyssey/ast/literals"
require "odyssey/ast/macro_def"
require "odyssey/ast/hash_exp"
require "odyssey/ast/and_exp"
require "odyssey/parsers/ruby_parser_converter"
require "refine"

module Odyssey
  def self.domacros code
    parsed = Parsers::RubyParserConverter.new(Ruby19Parser.new).translate(code)
    mf = MacroFinder.new(MacroDef)
    ma = MacroApplyer.new(mf, Message)
    to_ruby ma.apply(parsed)
  end

  def self.to_ruby(ast)
   ToRuby.new.call ast
  end

  # TODO support all of the possible options here
  def self.evaluator(*args, &block)
    MacroEvaluator.new(*args, &block)
  end

  class MacroEvaluator
    def initialize(*args, &block)
    end

    def evaluate code
      parsed = Parsers::RubyParserConverter.new(Ruby19Parser.new).translate(code)
      mf = MacroFinder.new(MacroDef)
      ma = MacroApplyer.new(mf, Message)
      ma.apply(parsed)
    end
  end
end


class OdysseyLoadFile
  def initialize file_to_load

    file_content = nil
    File.open(file_to_load) do |f|
      file_content = f.read
    end
    applied = Odyssey.domacros(file_content)
    puts eval(applied)
  end
  def find_file
  end
end



module Kernel
  alias :odyssey_original_load :load
  def load filename
    OdysseyLoadFile.new filename
    #odyssey_original_load *args
  end
end



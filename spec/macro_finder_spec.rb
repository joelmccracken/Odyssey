require_relative "./env"

class AMacro < Struct.new(:ident); end
class NotAMacro < Struct.new(:ident); end

class ThingWithMacros
  def initialize(statements)
    @statements = Struct.new(:body).new(statements)
  end
  def statements
    @statements
  end
end


describe "macro finder" do
  let (:macro_finder) {
    MacroFinder.new(AMacro)
  }
  it do
    ast = ThingWithMacros.new [NotAMacro.new(10), AMacro.new(1), AMacro.new(2)]
    macro_finder.find_macros(ast).must_equal [AMacro.new(1), AMacro.new(2)]
    macro_finder.without_macros(ast).must_equal [NotAMacro.new(10)]
  end
end

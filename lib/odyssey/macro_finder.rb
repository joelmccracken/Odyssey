# for now should only look in the top level
# of the passed code scope for now
# reallyyy wish I had a good plan for runtime macros

class MacroFinder
  def initialize(macro_class)
    @macro_class = macro_class
  end
  def find_macros(ast)
    ast.statements.body.select(&method(:is_a_macro))
  end

  def without_macros(ast)
    ast.statements.body.reject(&method(:is_a_macro))
  end

  private
  def is_a_macro(item)
    item.is_a?(@macro_class)
  end
end

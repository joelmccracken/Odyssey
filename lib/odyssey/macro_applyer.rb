# finds macros and applies them to syntax
# assumes self-contained
class MacroApplyer
  def initialize(macro_finder, message_class)
    @macro_finder = macro_finder
    @message_class = message_class
  end

  def apply(code)
    macros = @macro_finder.find_macros(code)
    code_without_macros = @macro_finder.without_macros(code)
    macros.each do |macro|
      code_without_macros = do_apply_macro macro, code_without_macros
    end
    code_without_macros
  end

  private
  def do_apply_macro(macro, code)
    ImplicitBlock.new(code.flat_map do |statement|
                        if statement.is_a?(@message_class) and statement.name == macro.name then
                          macro.block.body
                        else
                          statement
                        end
                      end)
  end
end

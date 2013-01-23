class Message < Struct.new(:target, :name, :arguments, :block)
  def find_macros
    if name == Sym.new(:defmacro)
      MacroDef.new(arguments, block)
    end
  end

  def ==(other)
    other &&
      target == other.target &&
      name == other.name &&
      arguments == other.arguments &&
      block == other.block
  end

  def inspect
    "Message(target: #{target.inspect}, msg: #{name.inspect}, args: #{arguments.inspect})"
  end
end

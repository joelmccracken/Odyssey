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

  def to_ruby
    ret = [name.to_ruby, arguments.to_ruby]
    ret.unshift(target.to_ruby) unless target.nil?
    ret.join " "
  end

  def inspect
    "#{target.inspect}.#{name.inspect}(#{arguments.inspect})(block #{block.inspect})"
  end
end

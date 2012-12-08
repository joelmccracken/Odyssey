class Message < Struct.new(:target, :message, :arguments, :block)
  def find_macros
    if message == Sym.new(:defmacro)
      MacroDef.new(arguments, block)
    end
  end

  def ==(other)
    other &&
      target == other.target &&
      message == other.message &&
      arguments == other.arguments &&
      block == other.block
  end

  def to_ruby
    ret = [message.to_ruby, arguments.to_ruby]
    ret.unshift(target.to_ruby) unless target.nil?
    ret.join " "
  end

  def inspect
    "#{target.inspect}.#{message.inspect}(#{arguments.inspect})(block #{block.inspect})"
  end
end

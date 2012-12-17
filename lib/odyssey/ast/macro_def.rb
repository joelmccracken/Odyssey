class MacroDef
  attr_accessor :name, :block

  def initialize(name, block)
    @name = name
    @block = block
  end

  def ==(other)
    name == other.name &&
      block == other.block
  end
end

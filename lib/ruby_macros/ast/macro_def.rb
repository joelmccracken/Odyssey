class MacroDef
  attr_accessor :name, :body

  def initialize(name, body)
    @name = name
    @body = body
  end

  def ==(other)
    name == other.name &&
      body == other.body
  end
end

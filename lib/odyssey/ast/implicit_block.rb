# represents a block of code
# the basic fundamental sequence of statements
# either as an implicit or explicit block
# a block may, or may not, have named parameters
# the top-level of each parsed program is a Block
# actual traditional "blocks" are also blocks
# the bodies of begin/rescue/ends are blocks
# the bodies of classes are blocks
# the bodies of methods are blocks
# I'm thinking there should be two types of blocks --
# implicit blocks, which just "are"

class ImplicitBlock < Struct.new(:body)
  def ==(other)
    other &&
      body == other.body
  end

  def statements
    body || []
  end
end


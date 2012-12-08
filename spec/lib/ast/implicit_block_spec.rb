describe ImplicitBlock do
  it "can represent an empty block" do
    ImplicitBlock.new.statements.must_equal []
  end

  it "can tell if it is equal to another block" do
    ImplicitBlock.new.must_equal ImplicitBlock.new
  end

  it "can accept a sequence of statements" do
    blk = ImplicitBlock.new []
  end

  it "can convert itself to ruby" do
    ImplicitBlock.new.to_ruby.must_equal ""
  end
end


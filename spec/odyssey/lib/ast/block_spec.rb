describe Block do
  it "can represent an empty block" do
    Block.new.statements.must_equal []
  end

  it "can tell if it is equal to another block" do
    Block.new.must_equal Block.new
  end


  it "can handle the case of having arguments" do
    blk = Block.new [:a]
    blk.arguments.must_equal [:a]
  end

  it "can accept a sequence of statements" do
    blk = Block.new nil, []
  end



end

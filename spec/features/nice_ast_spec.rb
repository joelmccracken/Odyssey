require_relative "../env.rb"

%q{ there should be a nice OO representation of syntax }
describe "Object-oriented Ruby syntax representations" do
  it "has objects for non-standard types" do
    ImplicitBlock.new([]).to_ruby.must_equal ""
    Block.new([:x], []).to_ruby.must_equal "{|x|}"

    Message.new(nil, Sym.new(:puts), Str.new("hi")).to_ruby.must_equal "puts \"hi\""

    Block.new([:x], nil).must_equal Block.new([:x], nil)

    Message.new(Num.new(1), Sym.new(:+), Num.new(1)).to_ruby.must_equal "1 + 1"
  end

  it "may or may not need these kinds of other objects for literals" do
    Num.new(1).to_ruby.must_equal("1")
  end
end

describe "proof of concept" do
  it do
    complete_macro_example = <<-EOF
    def_macro :my_macro do |m|
      :hi_mom
    end
    my_macro
    EOF

    Odyssey.domacros(complete_macro_example).must_equal [:hi_mom]
  end
end

describe "building andand" do
  it do
    andand_code = <<-EOF
    def_macro :my_macro do |m|
      m.replace(first_argument: m.args[0], second_argument: m.args[1]) do
        (temp = first_argument and temp.second_argument)
      end
    end
    1.andand(2)
    EOF

    next #pending
    # need to implement / test the converter next....

    code = Odyssey.domacros(andand_code)
    puts code.inspect
  end
end

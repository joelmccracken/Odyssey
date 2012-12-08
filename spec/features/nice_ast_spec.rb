require "env"

%q{ there should be a nice OO representation of syntax }
describe "Object-oriented Ruby syntax representations" do
  it do
    ImplicitBlock.new([]).to_ruby.must_equal ""
    Block.new([:x], []).to_ruby.must_equal "{|x|}"

    Message.new(nil, Sym.new(:puts), Str.new("hi")).to_ruby.must_equal "puts \"hi\""

    Block.new([:x], nil).must_equal Block.new([:x], nil)

    Num.new(1).to_ruby.must_equal("1")
    Message.new(Num.new(1), Sym.new(:+), Num.new(1)).to_ruby.must_equal "1 + 1"

  end
end

describe "parsing defmacro calls" do
  it "" do
    mparse("defmacro(:macro_name) {}").macros[0].must_equal MacroDef.new(Sym.new(:macro_name), Block.new(nil, []))
  end
end

describe "proof of concept" do
  it "" do
    return
    complete_macro_example = <<-EOF
      defmacro :my_macro do |m|
        :hi_mom
      end
      my_macro
    EOF
    domacros(complete_macro_example).must_equal :hi_mom
  end
end


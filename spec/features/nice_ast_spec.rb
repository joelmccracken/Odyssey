require_relative "../env.rb"

%q{ there should be a nice OO representation of syntax }
describe "Object-oriented Ruby syntax representations" do
  let(:to_ruby) {
    proc { |x| Odyssey.to_ruby x }
  }
  it do
    to_ruby.call(ImplicitBlock.new([])).
      must_equal ""

    to_ruby.call(Block.new([:x], [])).
      must_equal "{|x|}"

    to_ruby.call(Message.new(nil, :puts, ["hi"])).
      must_equal "puts(\"hi\")"

    to_ruby.call(Message.new(1, :+, [1])).
      must_equal "1 + 1"
  end

  it "may or may not need these kinds of other objects for literals" do
    Num.new(1).to_ruby.must_equal("1")
  end
end

describe "proof of concept" do
  it do
    skip "NIY"
    complete_macro_example = <<-EOF
    defmacro :my_macro do |m|
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
    defmacro :my_macro do |m|
      m.replace(first_argument: m.args[0], second_argument: m.args[1]) do
        (temp = first_argument and temp.second_argument)
      end
    end
    1.andand(2)
    EOF

    skip "NIY"

    # need to implement / test the converter next....

    code = Odyssey.domacros(andand_code)
    puts code.inspect
  end
end

require_relative "../spec_support"

describe "documenting the parse call" do
  let(:parser) do
    proc { |str|
      Odyssey::Parsers::RubyParserConverter.new(Ruby19Parser.new).translate(str)
    }
  end

  it do
    parser.call("1").statements.must_equal 1

    parser.call("1+1").statements.must_equal Message.new(1, :+, [1])

    parser.call("1+2+3").statements.must_equal Message.new(
                                                      Message.new(1, :+, [2]),
                                                      :+,
                                                      [3])

    parser.call("puts 'hi'").statements.must_equal Message.new(nil, :puts, ["hi"])

    parser.call("
      defmacro :lol do |m|
         puts 'hi'
      end").statements.must_equal  MacroDef.new(:lol,
                                           Block.new([:m],
                                                 [ Message.new(nil, :puts, ["hi"]) ]))
  end



  describe "parsing hashes" do
    it do
      parser.call("{:hi => \"there\"}").statements.must_equal HashExp.new :hi, "there"
    end
  end
end

require_relative "../env"

describe "documenting the parse call" do
  let(:scoot) do
    proc { |str|
      Odyssey::Parsers::RubyParserConverter.new(Ruby19Parser.new).translate(str)
    }
  end

  it do
    scoot.call("1").statements.must_equal 1

    scoot.call("1+1").statements.must_equal Message.new(1, :+, 1)

    scoot.call("1+2+3").statements.must_equal Message.new(
                                                      Message.new(1, :+, 2),
                                                      :+,
                                                      3)

    scoot.call("puts 'hi'").statements.must_equal Message.new(nil, :puts, "hi")

    scoot.call("
      defmacro :lol do |m|
         puts 'hi'
      end").statements.must_equal  MacroDef.new(:lol,
                                           Block.new([:m],
                                                 [ Message.new(nil, :puts, "hi") ]))

    #Odyssey.mparse("puts 'hi'").statements.to_ruby.must_equal 'puts "hi"'
  end
end

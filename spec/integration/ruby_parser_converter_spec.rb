require_relative "../../env"

describe "documenting the parse call" do
  it do
    Odyssey.mparse("1").statements.must_equal 1

    Odyssey.mparse("1+1").statements.must_equal Message.new(1, :+, 1)

    Odyssey.mparse("1+2+3").statements.must_equal Message.new(
                                                      Message.new(1, :+, 2),
                                                      :+,
                                                      3)

    Odyssey.mparse("puts 'hi'").statements.must_equal Message.new(nil, :puts, "hi")

    Odyssey.mparse("
      defmacro :lol do |m|
         puts 'hi'
      end").statements.must_equal  Message.new(nil, :defmacro, :lol,
                                         Block.new([:m],
                                               [ Message.new(nil, :puts, "hi") ]))

    # Odyssey.mparse("puts 'hi'").statements.to_ruby.must_equal 'puts "hi"'
  end
end

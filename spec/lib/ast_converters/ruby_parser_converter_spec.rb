require_relative "../../env"

describe "documenting the parse call" do
  it  do
    Odyssey.mparse("1").ast.must_equal 1

    Odyssey.mparse("1+1").ast.must_equal Message.new(1, :+, 1)

    Odyssey.mparse("1+2+3").ast.must_equal Message.new(
                                                      Message.new(1, :+, 2),
                                                      :+,
                                                      3)

    Odyssey.mparse("puts 'hi'").ast.must_equal Message.new(nil, :puts, "hi")

    Odyssey.mparse(<<-EOF
      defmacro :lol do |m|
         puts 'hi'
      end
      EOF
               ).ast.must_equal  Message.new(nil, :defmacro, :lol,
                                         Block.new([:m],
                                               [ Message.new(nil, :puts, "hi") ]))

    # Odyssey.mparse("puts 'hi'").ast.to_ruby.must_equal 'puts "hi"'
  end
end

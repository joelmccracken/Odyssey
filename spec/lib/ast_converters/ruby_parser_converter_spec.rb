require_relative "../../env"

describe "documenting the parse call" do
  it  do
    RubyMacros.mparse("1").ast.must_equal 1

    RubyMacros.mparse("1+1").ast.must_equal Message.new(1, :+, 1)

    RubyMacros.mparse("1+2+3").ast.must_equal Message.new(
                                                      Message.new(1, :+, 2),
                                                      :+,
                                                      3)

    RubyMacros.mparse("puts 'hi'").ast.must_equal Message.new(nil, :puts, "hi")

    RubyMacros.mparse(<<-EOF
      defmacro :lol do |m|
         puts 'hi'
      end
      EOF
               ).ast.must_equal  Message.new(nil, :defmacro, :lol,
                                         Block.new([:m],
                                               [ Message.new(nil, :puts, "hi") ]))

    # RubyMacros.mparse("puts 'hi'").ast.to_ruby.must_equal 'puts "hi"'
  end
end

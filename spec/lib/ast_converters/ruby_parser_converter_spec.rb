describe "documenting the parse call" do
  it  do
    mparse("1").ast.must_equal Num.new(1)

    mparse("1+1").ast.must_equal Message.new(Num.new(1), Sym.new(:+), Num.new(1))

    mparse("1+2+3").ast.must_equal Message.new(
                                       Message.new(Num.new(1), Sym.new(:+), Num.new(2)),
                                       Sym.new(:+),
                                       Num.new(3))

    mparse("puts 'hi'").ast.must_equal Message.new(nil, Sym.new(:puts), Str.new("hi"))

    mparse(<<-EOF
  defmacro :lol do |m|
    puts 'hi'
  end
EOF
    ).ast.must_equal  Message.new(nil, Sym.new(:defmacro), Sym.new(:lol),
                              Block.new([:m],
                                    [ Message.new(nil, Sym.new(:puts), Str.new("hi")) ]))


    mparse("puts 'hi'").ast.to_ruby.must_equal 'puts "hi"'
  end
end

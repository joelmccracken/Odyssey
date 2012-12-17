describe Refinery do
  it "ignores classes that have not been refined" do
    ref = Refinery.new
    "lol".class.must_equal ref.refine("lol").class
  end

  it "refines" do
    ref = Refinery.new do
      refine String do
        def to_ruby
          "\"#{to_s}\""
        end
      end
    end

    ref.refine("hi").to_ruby.must_equal "\"hi\""
    ref.refine("hi").length.must_equal 2

    proc do
      "hi".to_ruby
    end.must_raise NoMethodError
  end
end

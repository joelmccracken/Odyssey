require_relative "env"
require "odyssey/to_ruby"

describe ToRuby do
  let(:subj) { ToRuby.new }

  it "renders certain native types natively" do
    subj.call(1).must_equal "1"
    subj.call("hi").must_equal "\"hi\""
  end
  it "uses to_ruby on objects that are form " do
    x = Class.new do
      def to_ruby(ast_converter)
        :xyzabc
      end
    end
    subj.call(x.new).must_equal :xyzabc
  end

  it "can convert blocks to ruby" do
    subj.call(Block.new).must_equal "{}"
    subj.call(Block.new([:x, :y])).must_equal "{|x,y|}"
    subj.call(Block.new([:x, :y], [])).must_equal "{|x,y|}"
  end


  it "can convert messages to ruby" do
    subj.call(Message.new(nil, :doot, ["hey"])).must_equal "doot(\"hey\")"
  end

end


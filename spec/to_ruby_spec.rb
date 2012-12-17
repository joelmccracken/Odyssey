require "env"
require "odyssey/to_ruby"

describe ToRuby do
  let(:subj) { ToRuby.new }

  it "renders certain native types natively" do
#    subj.call(1).must_equal "1"
    subj.call("hi").must_equal "\"hi\""
  end
  it "uses to_ruby on objects that are form " do
    next
    x = Class.new do
      include Odyssey
      def to_ruby
        :xyzabc
      end
    end
    subj.call(x.new).must_equal :xyzabc
  end
end


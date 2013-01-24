require_relative "./env"


macro = Struct.new(:name, :block)
message = Struct.new(:name)

block = Struct.new(:body)

describe MacroApplyer do

  let(:find_macros_return) { [macro.new(:qwert, block.new([:funky]))] }
  let(:without_macros_return) { [message.new(:qwert)]  }

  let(:macro_finder) do
    Class.new(Struct.new(:find_macros_return, :without_macros_return)) do
      define_method(:find_macros) {|ast| find_macros_return }
      define_method(:without_macros) {|ast| without_macros_return }
    end.new(find_macros_return, without_macros_return)
  end

  let(:macro_applyer) { MacroApplyer.new(macro_finder, message) }
  describe "a simple macro example" do
    it do
      macro_applyer.apply(nil).must_equal ImplicitBlock.new([:funky])
    end
  end
end

require_relative '../env.rb'

describe "the user interface" do
  it "provides users the ability to add macros to runtime evaluated code" do
    RubyMacros.evaluator().evaluate(%q{
      defmacro :my_macro do
        :hi_mom
      end
      my_macro
    }).must_equal [:hi_mom]
  end
end


require_relative "../spec_support"

describe "the user interface" do
  it "provides users the ability to add macros to runtime evaluated code" do
    skip "NIY"
    Odyssey.evaluator().evaluate(%q{
      defmacro :my_macro do
        :hi_mom
      end
      my_macro
    }).must_equal [:hi_momm]
  end
end

describe "ugh how on earth am i supposed to test this??" do
  it do
    itest = OdysseyIntegrationTest.new

    itest.file "macro_definitions.rb", <<-EOF
      defmacro :my_macro do
        1+2
      end
      my_macro
    EOF

    itest.file "startup.rb", <<-EOF
      require 'odyssey'
      load 'macro_definitions.rb'
    EOF
    itest.run("startup.rb").must_match /3/
  end
end

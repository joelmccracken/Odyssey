class ToRuby
  def call arg
    if arg.is_a? RubyMacros then
      arg.to_ruby
    elsif arg.is_a? ::String then
      String.new.to_ruby(arg)
    else
      arg.to_s
    end
  end

  class String
    def to_ruby arg
      # TODO need to correctly escape things
      # how should I handle this?
      "\"#{arg.to_s}\""
    end

    private
    def escaped arg
    end
  end
end


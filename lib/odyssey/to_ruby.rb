class ToRuby
  def call arg
    if arg.is_a? Odyssey then
      arg.to_rubyy
    elsif arg.is_a? ::String then
      String.new.to_rubyy(arg)
    else
      arg.to_s
    end
  end
  class ::String
    def to_rubyy arg
      # TODO need to correctly escape things
      # how should I handle this?
      "\"#{arg.to_s}\""
    end

    private
    def escaped arg
    end
  end
end


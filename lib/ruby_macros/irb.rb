require "irb"

class IRB::WorkSpace
  alias :original_evaluate :evaluate
end
class IRB::WorkSpace
  def evaluate(*args)
    (@history ||= []) << args[1];
    @history << args[1]
    original_evaluate(*args)
  end
end



# IRB.conf[:MAIN_CONTEXT].workspace

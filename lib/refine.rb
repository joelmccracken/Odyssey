require 'delegate'

class Refinery
  def initialize(&refine_def)
    @refinement_definition = RefinementDefinition.new
    @refinement_definition.instance_eval &refine_def if block_given?
  end

  def refine(raw_object)
    @refinement_definition.perform_refine(raw_object)
  end

  class SingleRefinementDefinition
    def initialize(type, &defn_block)
      @type = type

      @refined_class = Class.new(SimpleDelegator)

      @refined_class.class_eval(&defn_block) if block_given?
    end

    def matches?(obj)
      obj.is_a? @type
    end

    def perform_refine obj
      @refined_class.new obj
    end
  end

  class RefinementDefinition
    def initialize
      @refinements = []
    end

    def refine type, &def_blk
      @refinements << SingleRefinementDefinition.new(type, &def_blk)
    end

    def perform_refine obj
      selected_ref = @refinements.select do |ref|
        ref.matches? obj
      end
      if selected_ref.first
        selected_ref.first.perform_refine obj
      else
        obj
      end
    end
  end
end

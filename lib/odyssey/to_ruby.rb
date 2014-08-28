require 'refine'

class ToRuby
  def call arg
    refined = ref.refine(arg)
    if refined.respond_to? :to_ruby
      refined.to_ruby(self)
    else
      throw "Not to_ruby-able: #{refined.inspect}"
    end
  end

  private
  def ref
    @ref ||=
      Refinery.new do
      refine String do
        def to_ruby converter=nil
          "\"#{to_s}\""
        end
      end
      refine Numeric do
        def to_ruby converter=nil
          to_s
        end
      end
      refine Message do
        def is_special? sym
          [:+].member? sym
        end

        def to_ruby converter=nil
          ruby_version = []
          if is_special? name
            "#{target.to_s} #{name.to_s} #{arguments.first.to_s}"
          else
            if target
              ruby_version << target.to_s
              ruby_version << "."
            end
            ruby_version << name.to_s
            ruby_version << "("
            if arguments
              ruby_version << (arguments.map do |arg|
                  converter.call(arg)
                end.join(', '))
            end
            ruby_version << ")"
            ruby_version.join
          end
        end

      end
      refine ImplicitBlock do
        def to_ruby converter=nil
          statements.map do |statement|
            converter.call(statement)
          end.join "\n"
        end
      end

      refine Block do
        def to_ruby converter=nil
          ruby_str = [arguments_ruby, body_ruby].reject(&:empty?).join(" ")
          "{#{ruby_str}}"
        end

        def arguments_ruby
          args_together = arguments && arguments.map(&:to_s).join(",")
          if args_together then "|#{args_together}|" else "" end
        end

        def body_ruby
          statements.map(&:to_ruby).join "\n"
        end
      end
      refine Symbol do
        def to_ruby(converter=nil)
          ":\"#{self}\""
        end
      end
    end
  end
end


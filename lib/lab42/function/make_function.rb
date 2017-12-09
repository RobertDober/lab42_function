module Lab42
  class Function
    module MakeFunction extend self

      def make_function from
        case from
        when Symbol
          Lab42::Function.free_receiver from
        when Array
          make_function_from_ary from
        when Proc, Method
          Lab42::Function.new from, from.arity
        when Lab42::Function
          from
        else
          raise ArgumentError, "cannot make a behavior from #{from.inspect}"
        end
      end
      
      def make_function_from_ary ary
        case ary.first
        when Symbol
          Lab42::Function.free_receiver( *ary )
        else
          Lab42::Function.partial( *ary )
        end
      end
    end
  end
end

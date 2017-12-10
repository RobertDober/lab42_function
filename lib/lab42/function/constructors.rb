module Lab42
  class Function
    module Constructors
      require_relative 'params_reorderer'

      R = Lab42::Function::ParamsReorderer

      def constant const_val
        new ->{ const_val }, 0
      end
      alias_method :c, :constant

      def free_receiver msg, *first_stage_params, &blk
        unless blk
          return new ->(rcv, *second_stage_params){
            mthd = rcv.method(msg)
            mthd.(*R.combine_and_reorder(first_stage_params, second_stage_params))
          }
        end

        chained_free_receiver msg, first_stage_params, blk
      end
      # The free_receiver's abbreviation s stands for `send`
      alias_method :s, :free_receiver

      def force_pipe
        @__force_pipe__ ||= BasicObject.new
      end
      alias_method :f, :force_pipe

      def partial rcv, msg, *first_stage_params, &blk
        mthd = rcv.method msg
        unless blk
          return new ->(*second_stage_params){
            mthd.(*R.combine_and_reorder(first_stage_params, second_stage_params))
          }
        end

        chained_partial mthd, first_stage_params, blk
      end
      alias_method :p, :partial

      def placeholder n
        Function::Placeholder.make(n)
      end
      alias_method :a, :placeholder
      def a1; placeholder 1 end
      def a2; placeholder 2 end
      def a3; placeholder 3 end

      private

      def chained_free_receiver msg, first_stage_params, blk
        new ->(rcv, *second_stage_params){
          mthd = rcv.method msg
          beh_params, blk_params = split_by_arity(mthd, second_stage_params)
          blk_params ||= []
            raise ArgumentError unless blk.arity == blk_params.size + 1 || blk.arity < 0
          blk.(mthd.(*R.combine_and_reorder(first_stage_params, beh_params)), *blk_params)
        }
      end

      def chained_partial mthd, first_stage_params, blk
        new ->(*second_stage_params){
          beh_params, blk_params = split_by_arity(mthd, second_stage_params)
          blk_params ||= []
          raise ArgumentError unless blk.arity == blk_params.size + 1 || blk.arity < 0
          blk.(mthd.(*R.combine_and_reorder(first_stage_params, beh_params)), *blk_params)
        }
      end

      def split_by_arity mthd, params
        return [params, []] if mthd.arity < 0

        a = mthd.arity
        [params[0...a], params[a..-1]]
      end

    end
  end
end

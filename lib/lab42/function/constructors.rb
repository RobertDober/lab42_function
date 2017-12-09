module Lab42
  class Function
    module Constructors

      def partial rcv, msg, *first_stage_params, &blk
        mthd = rcv.method msg
        unless blk
          return new ->(*second_stage_params){
            mthd.(*(first_stage_params + second_stage_params))
          }
        end

        chained_partial mthd, first_stage_params, blk
      end
      alias_method :p, :partial


      private

      def chained_partial mthd, first_stage_params, blk
        new ->(*second_stage_params){
          beh_params, blk_params = split_by_arity(mthd, second_stage_params)
          blk_params ||= []
          raise ArgumentError unless blk.arity == blk_params.size + 1
          blk.(mthd.(*(first_stage_params + beh_params)), *blk_params)
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

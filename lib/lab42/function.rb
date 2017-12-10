# Namespace of almost all my gems, certainly all which are marked
# as **Unintrusive** or **Isolated**
module Lab42
  # Implementation of the isolated functional behavior
  #
  #   - Partials
  #   - Chaining
  #
  class Function

    require_relative 'function/constructors'
    require_relative 'function/make_function'
    require_relative 'function/my'
    require_relative 'function/placeholder'

    extend Constructors

    attr_reader :behavior, :arity

    def | rhs
      return call if rhs == self.class.force_pipe
      rhs = MakeFunction.make_function rhs
      self.class.new ->{
        rhs.call(self.call)
      }
    end

    def initialize behavior, arity=-1
      @behavior = behavior
      @arity    = arity
    end

    def call *second_stage_params
      behavior.(*second_stage_params)
    end

  end
end

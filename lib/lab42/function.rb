require_relative 'function/constructors'
# Namespace of almost all my gems, certainly all which are marked
# as **Unintrusive** or **Isolated**
module Lab42
  # Implementation of the isolated functional behavior
  #   
  #   - Partials
  #   - Chaining
  # 
  class Function
    extend Constructors

    attr_reader :behavior

    def initialize behavior
      @behavior = behavior
    end

    def call *second_stage_params
      behavior.(*second_stage_params)
    end
  end
end

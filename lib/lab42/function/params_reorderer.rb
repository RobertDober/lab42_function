module Lab42::Function::ParamsReorderer extend self
  
  def combine_and_reorder first_stage_params, second_stage_params
    store = Hash[*second_stage_params.each_with_index.to_a.flatten.reverse]
    first_stage_params.map{ | fst_param |
      case fst_param
      when Lab42::Function::Placeholder
        fetch_and_delete store, fst_param.arg_number.pred
      else
        fst_param
      end
    } + store.to_a.sort_by(&:first).map(&:last)
  end


  private

  def fetch_and_delete hash, key
    hash.fetch(key){ |n|
      raise ArgumentError, "placeholder parameter #{n.succ} not provided for"
    }.tap {
      hash.delete key
    }
  end
  
end

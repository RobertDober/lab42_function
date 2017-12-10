
class Lab42::Function::Placeholder

  class << self

    def make n
      return cache.fetch(n){ cache[n] = new(n) }
    end


    private

    def new n
      super
    end

    # Lazy Values
    # -----------
    def cache
       @__cache__ ||= {}
    end

  end

  attr_reader :arg_number

  private

  def initialize n
    raise ArgumentError, "only positive argument numbers are allowed, not #{n}" unless n.positive?
    @arg_number = n
  end
end

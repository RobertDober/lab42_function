RSpec.describe F do

  class Example
    include F::My

    class << self
      include F::My

      def chain *args
        args.flatten.reverse
      end

      def chain_with_suffix suffix, *rest
        my_method(:chain, *suffix, *rest)
      end
    end

    def chain *args
      args.flatten
    end

    def chain_with_prefix prefix, *rest
      my_method(:chain, *prefix)
    end

    def chain_with_suffix suffix, *rest
      my_class_method(:chain, *suffix, *rest)
    end
  end

  describe F::My do 

    context 'on instance' do
    let( :example ){ Example.new }

      it { expect(example.chain_with_prefix(:omega).(:alpha, :beta))
        .to eq(%i[omega alpha beta]) }
      it { expect(example.chain_with_suffix([:omega, :psi], :beta).(:alpha))
        .to eq(%i[alpha beta psi omega]) }
    end

    context 'on class' do 
    let( :example ){ Example }
      it { expect(example.chain_with_suffix([:omega, :psi], :beta).(:alpha))
        .to eq(%i[alpha beta psi omega]) }
      
    end
    
  end

end

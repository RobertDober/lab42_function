RSpec.describe F do
  describe F::MakeFunction do 

    context 'from block' do 
      let( :fun ){ described_class.make_function(->x{x}) }

      it { expect(fun).to be_kind_of(F) }
      it { expect(fun.(42)).to eq(42) }
      it { expect(fun.arity).to eq(1) }

      it { expect{ fun.() }.to raise_error(ArgumentError) }
    end
    
    context 'intercept nonsensical values' do 
      it { expect{ described_class.make_function(42) }.to raise_error(ArgumentError) }
    end

    context 'from array is a little bit tricky' do 
      let( :free_rcv ){ described_class.make_function([:succ]) }
      let( :partial ){ described_class.make_function([40, :+]) }

      it { expect(free_rcv.(41)).to eq(42) }
      it { expect(partial.(2)).to eq(42) }
    end
  end
end

RSpec.describe F do

  #
  # Free Receiver Form:
  # -------------------
  #
  # A partial function with a free first parameter that will be filled in as receiver
  # at call time.
  #
  # Thusly `free_receiver(:size)` is a function, that, when called with a param will
  # send `:size` to the param.
  describe 'free receiver form' do

    context 'w/o a block' do
      let( :incrementer ){ F.free_receiver(:+, 1) }
      let( :incrementer_by ){ F.free_receiver(:+) }

      it { expect(incrementer.(41)).to eq(42) }
      it { expect{ incrementer.() }.to raise_error(ArgumentError) }
      it { expect{ incrementer.(1, 3) }.to raise_error(ArgumentError) }

      it { expect(incrementer_by.(41, 1)).to eq(42) }
      it { expect(incrementer_by.(41, 2)).to eq(43) }
      it { expect{ incrementer_by.() }.to raise_error(ArgumentError) }
      it { expect{ incrementer_by.(1) }.to raise_error(ArgumentError) }
      it { expect{ incrementer_by.(43, 44, 45) }.to raise_error(ArgumentError) }
    end

    # The free_receiver's abbreviation s stands for `send`
    context 'with a block' do 
      context 'no second stage params' do
        let( :double_plus2 ){ F.s(:succ){|x| x * 2 } }

        it { expect(double_plus2.(20)).to eq(42) }
        it { expect{ double_plus2.() }.to raise_error(ArgumentError) }
        it { expect{ double_plus2.(1, 3) }.to raise_error(ArgumentError) }
      end

      context 'all second stage params go to block' do 
        let( :inc_and_mult_by ){ F.s(:succ){ |x, n| x * n } }

        it { expect(inc_and_mult_by.(20, 2)).to eq(42) }
        it { expect(inc_and_mult_by.(20, 3)).to eq(63) }
        
        it { expect{ inc_and_mult_by.() }.to raise_error(ArgumentError) }
        it { expect{ inc_and_mult_by.(1) }.to raise_error(ArgumentError) }
        it { expect{ inc_and_mult_by.(1, 3, 7) }.to raise_error(ArgumentError) }
      end

      context 'all second stage params go to partial' do 
        let( :mult_by_and_inc ){ F.s(:*, &:succ) }

        it { expect(mult_by_and_inc.(10, 3)).to eq(31) }

        it { expect{ mult_by_and_inc.() }.to raise_error(ArgumentError) }
        it { expect{ mult_by_and_inc.(10) }.to raise_error(ArgumentError) }
        it { expect{ mult_by_and_inc.(10, 11, 12) }.to raise_error(ArgumentError) }
      end

      context 'second stage params shared' do 
        let( :add_and_mult ){ F.s(:+){|x, n| x * n } }

        it { expect(add_and_mult.(20, 1, 2)).to eq(42) }

        it { expect{ add_and_mult.() }.to raise_error(ArgumentError) }
        it { expect{ add_and_mult.(1) }.to raise_error(ArgumentError) }
        it { expect{ add_and_mult.(1, 3) }.to raise_error(ArgumentError) }
        it { expect{ add_and_mult.(1, 3, 9, 27) }.to raise_error(ArgumentError) }
      end
    end
  end

end

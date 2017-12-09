RSpec.describe F do
  
  describe 'partial receiver form' do

    context '0 params missing' do 
      let( :ary ){ %w{a b c} }
      let( :f ){ F.p(ary, :size) }

      it { expect(f.()).to eq(3) }
      it { expect(f).to be_kind_of(F) }
      it { expect{f.(1)}.to raise_error(ArgumentError) }
    end

    context '1 param missing' do 
      let( :n ){ 41 }
      let( :f ){ F.partial(n, :+) }

      it { expect(f.(1)).to eq(42) }
      it { expect{f.()}.to raise_error(ArgumentError) }
      it { expect{f.(1, 3)}.to raise_error(ArgumentError) }
    end

    context 'chain with block' do 
      let( :n ){ 41 }
      let( :f ){ F.partial(n, :-){|x, n| x + n} }
      
      it { expect(f.(1, 2)).to eq(42) }
      it { expect{f.()}.to raise_error(ArgumentError) }
      it { expect{f.(1)}.to raise_error(ArgumentError) }
      it { expect{f.(1, 4, 7)}.to raise_error(ArgumentError) }
    end

  end


end

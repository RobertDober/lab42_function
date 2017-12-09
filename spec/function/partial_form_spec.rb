RSpec.describe F do

  #
  # Partial Receiver Form:
  # ----------------------
  #
  # A partial function with a fixed first parameter that is a receiver and
  # a fixed second parameter that is a message which will be send to the
  # receiver at call time.
  #
  # Thusly `partial(42, :-)` is a function, that, when called with a param will
  # send `:-`, param to 42
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

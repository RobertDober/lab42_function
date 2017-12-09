RSpec.describe F do
  context 'piping, à la Elixir' do 

    describe 'other Functions' do
      let( :answer_fn ){ F.c(2) | F.p(3, :* ) | F.s( :succ ) }

      it { expect(answer_fn).to be_kind_of(F) }
      it { expect(answer_fn.()).to eq(7) }
    end

    describe 'shortcuts' do
      let( :answer_fn ){ F.c(2) | [3, :*] | :succ }
      
      it { expect(answer_fn).to be_kind_of(F) }
      it { expect(answer_fn.()).to eq(7) }
    end

    describe 'force result' do
      it { expect( F.c(2) | F.p(3, :*) | :succ | F.f ).to eq(7)  }
    end

  end
end

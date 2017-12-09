RSpec.describe F do
  context 'constant functions' do 
    let( :answer_fn ){ F.constant 42 }

    it { expect(answer_fn).to be_kind_of(F) }
    it { expect(answer_fn.()).to eq(42) }

    it { expect{ answer_fn.(1) }.to raise_error(ArgumentError) }

    it { expect(F.c(43).()).to eq(43) }
  end
end

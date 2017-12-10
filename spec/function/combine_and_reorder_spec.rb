RSpec.describe F::ParamsReorderer do

  context 'provides a reordering helper' do 
    
    context 'only one' do 
      let( :first_satge_params ){ [:a, F.a2, :c] }
      let( :second_stage_params ){ [:d, :b] }

      it { expect(described_class.combine_and_reorder(first_satge_params, second_stage_params))
        .to  eq(%i[a b c d]) }
    end

    context 'some' do 
      let( :first_satge_params ){ [:a, F.a2, :c, F.a(4), F.a3] }

      it { expect(described_class.combine_and_reorder(first_satge_params, %i[f b e d]))
        .to eq(%i[a b c d e f]) }

      it { expect{ described_class.combine_and_reorder(first_satge_params, %i[f b e]) } 
        .to raise_error(ArgumentError) }
    end

  end
  
end

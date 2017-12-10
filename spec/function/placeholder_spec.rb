RSpec.describe F::Placeholder do

  let( :access_cache ){ ->{ described_class.send( :cache ) } }
  let( :one ){ described_class.make 1 }
  let( :two ){ described_class.make 2 }

  before { access_cache.().clear }

  context 'cache avoids unnecessary object allocation' do 
    it 'allocates only one per n' do
      expect( access_cache.().size ).to eq(0)

      expect( one ).to be_kind_of(described_class)
      expect( one.arg_number ).to eq(1)
      expect( access_cache.().size ).to eq(1)

      described_class.make 1
      expect( access_cache.().size ).to eq(1)

      expect( two.arg_number ).to eq(2)
      described_class.make 2
      expect( two.arg_number ).to eq(2)
    end

    it 'returns the correctly cached values' do
      expect( one ).to eq( access_cache.()[1])
      expect( two ).to eq( access_cache.()[2])
    end
  end

  context 'shortcuts' do
    it 'are provided in F' do
      expect( F.a1 ).to eq( one )
      expect( F.a2 ).to eq( two )
      expect( F.a3 ).to eq( described_class.make(3) )
      expect( access_cache.().size ).to eq(3)
    end
  end

  context 'new is private' do 
    it { expect{ described_class.new( 42 ) }.to raise_error(NoMethodError)  }
  end

  context 'only positive values are allowed' do 
    it { expect{ described_class.make( 0 ) }.to raise_error(ArgumentError) }
    it { expect{ described_class.make( -3 ) }.to raise_error(ArgumentError) }
  end

end

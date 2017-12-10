RSpec.describe F do

  describe 'paramter reordering' do
    
    let( :dyslex ){ F.p(self, :operation, F.a(2), F.a(1))  }

    it { expect(dyslex.(1,2)).to eq(3) }


    def operation a, b; 2*a - b end
  end
  
end

require 'lab42/function/version'
RSpec.describe Lab42::Function::VERSION do
  
  it 'is semantic' do
    expect(Lab42::Function::VERSION).to match %r{\A \d+ \. \d+ \. \d+ \z}x
  end

end

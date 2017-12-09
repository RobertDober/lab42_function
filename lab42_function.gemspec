$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'lab42/function/version'
version = Lab42::Function::VERSION
Gem::Specification.new do |s|
  s.name        = 'lab42_function'
  s.version     = version
  s.summary     = 'Functional Behavior Isolated'
  s.description = %{partials, chainable, composable functions; all isolated into Lab42::Function; unintrusive; depedence free; pure Ruby} 
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w{LICENSE README.md}
  s.homepage    = "https://github.com/RobertDober/lab42_function"
  s.licenses    = %w{Apache 2}

  s.required_ruby_version = '>= 2.3.1'

  s.add_development_dependency 'pry', '~> 0.11'
  s.add_development_dependency 'pry-byebug', '~> 3.5'

  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'simplecov', '~> 0.15'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'

  s.add_development_dependency 'travis-lint', '~> 2.0'
  # s.add_development_dependency 'rake', '~> 10.3'
end

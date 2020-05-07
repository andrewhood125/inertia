
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "inertia/version"

Gem::Specification.new do |spec|
  spec.name          = "inertia"
  spec.version       = Inertia::VERSION
  spec.authors       = ["Andrew Hood"]
  spec.email         = ["andrewhood125@gmail.com"]

  spec.summary       = 'Where is your codes center of mass?'
  spec.description   = 'Sleuth through code with information about complexity distribution'
  spec.homepage      = "https://github.com/andrewhood125/inertia"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = 'in'
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.4.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'pry'
end

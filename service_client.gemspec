require_relative 'lib/service_client/version'

Gem::Specification.new do |spec|
  spec.name          = "service_client"
  spec.version       = ServiceClient::VERSION
  spec.authors       = ["Alef Ojeda de Oliveira"]
  spec.email         = ["alef.oliveira@dimensa.com.br"]

  spec.summary       = "Service client"
  spec.description   = "Service client"
  spec.homepage      = "https://github.com/nemuba/service_client"
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.7.1'
  spec.extra_rdoc_files = ['doc/index.html']

  spec.metadata["homepage_uri"] = "https://github.com/nemuba/service_client"
  spec.metadata["source_code_uri"] = "https://github.com/nemuba/service_client"
  spec.metadata["changelog_uri"] = "https://github.com/nemuba/service_client/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir['lib/**/*.rb'] + Dir['bin/*']
  spec.files += Dir['[A-Z]*']
  spec.files.reject! { |fn| fn.include? "CVS" }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "= 2.1.4"
  spec.add_dependency "httparty", "~> 0.18.0"
end

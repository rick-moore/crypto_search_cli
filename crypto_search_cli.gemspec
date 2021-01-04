require_relative 'lib/crypto_search_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "crypto_search_cli"
  spec.version       = CryptoSearchCli::VERSION
  spec.authors       = ["Rick Moore"]
  spec.email         = ["dirklo@gmail.com"]

  spec.summary       = %q{Searches for the most popular crytocurrencies and their details.}
  spec.description   = %q{Provides a scaling list of cryptocurrencies, scraped from https://coinmarketcap.com/all/views/all/, and matches with information scraped from https://www.coingecko.com/api/documentations/v3#/ . Allows user to quickly retrieve current and historical market information and developer statistics on those cryptocurrenncies.}
  spec.homepage      = "https://www.github.com/dirklo/crypto_search_cli"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://www.github.com/dirklo/crypto_search_cli"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/dirklo/crypto_search_cli"
  spec.metadata["changelog_uri"] = "https://www.github.com/dirklo/crypto_search_cli/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_dependency "money"
  spec.add_dependency "monetize"
  spec.add_dependency "rainbow"
  spec.add_dependency "date"
  
  spec.add_development_dependency "pry"
end

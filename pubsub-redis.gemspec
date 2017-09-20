# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pubsub/redis/version"

Gem::Specification.new do |spec|
  spec.name          = "codingstones-pubsub-redis"
  spec.version       = Pubsub::Redis::VERSION
  spec.authors       = ["The Coding Stones"]
  spec.email         = ["yeah@codingstones.com"]

  spec.summary       = %q{A pubsub implementation with redis pubsub.}
  spec.description   = %q{An utility for our development stuff.}
  spec.homepage      = "https://github.com/codingstones/pubsub-redis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pubsub"
  spec.add_dependency "redis"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
end

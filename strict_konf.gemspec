# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
version = File.read(File.dirname(__FILE__) + '/VERSION').strip

Gem::Specification.new do |spec|
  spec.name          = "strict_konf"
  spec.version       = version
  spec.authors       = ["Wojtek Mach"]
  spec.email         = ["wojtek@wojtekmach.pl"]
  spec.summary       = "Extend Konf to require/whitelist fields"
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_dependency "konf", "0.0.2"
end

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "mobile_enhancements/version"

Gem::Specification.new do |s|
  s.name          = "mobile-enhancements"
  s.version       = MobileEnhancements::VERSION
  s.authors       = ["Ryan Townsend"]
  s.email         = ["ryan@ryantownsend.co.uk"]
  s.description   = "This gem provides a few features to a Rails app which aid the production of a mobile-targeted UI."
  s.summary       = "A few features to aid Rails apps with separate mobile-targeted UIs."
  s.homepage      = "https://github.com/ryantownsend/mobile-enhancements"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "combustion"
end

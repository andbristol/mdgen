# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mdgen/version'

Gem::Specification.new do |spec|
  spec.name          = 'mdgen'
  spec.version       = MDGen::VERSION
  spec.authors       = ['Andy Bristol']

  spec.summary       = %q{Tool for generating Markdown documents}
  spec.homepage      = 'https://github.com/andbristol/mdgen'
  spec.license       = 'MIT'

  spec.files         = %x{git ls-files -z}.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end

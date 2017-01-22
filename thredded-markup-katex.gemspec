# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thredded/markdown_katex/version'

Gem::Specification.new do |s|
  s.name          = 'thredded-markdown_katex'
  s.version       = Thredded::MarkdownKatex::VERSION
  s.authors       = ['Gleb Mazovetskiy']
  s.email         = ['glex.spb@gmail.com']

  s.summary       = 'Adds TeX math support to Thredded markup via KaTeX.'
  s.description   = 'Adds TeX math support to Thredded markup via KaTeX.'
  s.homepage      = "TODO: Put your gem's website or public repo URL here."
  s.license       = 'MIT'

  s.required_ruby_version = '~> 2.3'

  s.files = Dir['{exe,lib}/**/*'] + %w(LICENSE.txt README.md)
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1.14'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'simplecov'
end

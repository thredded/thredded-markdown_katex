# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thredded/markdown_katex/version'

Gem::Specification.new do |s|
  s.name          = 'thredded-markdown_katex'
  s.version       = Thredded::MarkdownKatex::VERSION
  s.authors       = ['Gleb Mazovetskiy']
  s.email         = ['glex.spb@gmail.com']

  s.summary       = 'Adds TeX math support to Thredded markup via KaTeX.'
  s.description   = 'Adds TeX math support to Thredded markup via KaTeX.'
  s.homepage      = 'https://github.com/thredded/thredded-markdown_katex'
  s.license       = 'MIT'

  s.required_ruby_version = '>= 2.5'

  s.files = Dir['{lib}/**/*'] + %w[LICENSE.txt README.md]
  s.require_paths = ['lib']

  s.add_dependency 'katex', '>= 0.4.3'
  s.add_dependency 'kramdown-math-katex'

  s.add_development_dependency 'bundler', '~> 2.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 1.22.1'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'thredded', '>= 0.11.0'
end

# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in thredded-markdown_katex.gemspec
gemspec

gem 'thredded', git: 'https://github.com/thredded/thredded', branch: 'loosen-ruby-requirement'

if ENV['TRAVIS']
  group :test do
    # CodeClimate coverage reporting.
    gem 'codeclimate-test-reporter', require: false
  end
end

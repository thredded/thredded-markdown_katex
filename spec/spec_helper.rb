# frozen_string_literal: true

if ENV['COVERAGE'] && !%w[rbx jruby].include?(RUBY_ENGINE)
  require 'simplecov'
  SimpleCov.command_name 'RSpec'
end

require 'bundler/setup'

require 'thredded'
require 'thredded/content_formatter'

Thredded::ContentFormatter.class_eval do
  def content_pipeline_options
    {
      whitelist: Thredded::ContentFormatter.whitelist,
      # This comes from Rails by default, but we don't want to load Rails:
      asset_root: '/'
    }
  end
end

require 'thredded/markdown_katex'
Thredded::MarkdownKatex.setup!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

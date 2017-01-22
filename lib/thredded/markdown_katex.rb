# frozen_string_literal: true
require 'thredded/markdown_katex/version'
require 'thredded/markdown_katex/railtie' if defined?(Rails)

module Thredded
  # Adds TeX math support to Thredded markdown via KaTeX.
  module MarkdownKatex
    @options = {}

    class << self
      attr_reader :options

      def setup!

      end
    end
  end
end

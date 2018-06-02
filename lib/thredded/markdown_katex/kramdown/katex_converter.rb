# frozen_string_literal: true

# KaTeX support for Kramdown < v1.17.0 (newer versions have built-in support).

module Thredded
  module MarkdownKatex
    module Kramdown
      # The KaTeX converter engine for Kramdown.
      module KatexConverter
        # rubocop:disable Metrics/AbcSize,Metrics/MethodLength

        def self.call(converter, el, opts)
          display_mode = el.options[:category] == :block
          result = ::Katex.render(
            el.value,
            display_mode: display_mode,
            throw_on_error: false,
            **converter.options[:math_engine_opts]
          )
          attr = el.attr.dup
          attr.delete('xmlns')
          attr.delete('display')
          result
            .insert(result =~ /[[:space:]>]/, converter.html_attributes(attr))
          result = "#{' ' * opts[:indent]}#{result}\n" if display_mode
          result
        end
        # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
      end
    end
  end
end

require 'kramdown/converter'
Kramdown::Converter
  .add_math_engine(:katex, ::Thredded::MarkdownKatex::Kramdown::KatexConverter)

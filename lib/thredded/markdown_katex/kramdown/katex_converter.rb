# frozen_string_literal: true
module Thredded
  module MarkdownKatex
    module Kramdown
      # The KaTeX converter engine for Kramdown.
      module KatexConverter
        def self.call(_converter, el, _opts)
          type = el.options[:category]
          Katex.render(
            el.value, display_mode: type == :block, throw_on_error: false
          )
        end
      end
    end
  end
end

require 'kramdown/converter'
Kramdown::Converter.module_eval do
  add_math_engine :katex do |converter, el, opts|
    add_math_engine(:katex, ::Thredded::MarkdownKatex::Kramdown::KatexConverter)
    math_engine(:katex).call(converter, el, opts)
  end
end

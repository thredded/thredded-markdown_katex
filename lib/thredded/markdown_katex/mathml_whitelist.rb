# frozen_string_literal: true

require 'thredded/markdown_katex/mathml_allowlist'

module Thredded
  module MarkdownKatex
    # @deprecated use MathMLAllowlist instead
    # TODO: drop when release 2.0
    module MathMLWhitelist
      include MathMLAllowlist

      PRESENTATION_WHITELIST = PRESENTATION_ALLOWLIST
      OTHER_WHITELIST = OTHER_ALLOWLIST
    end
  end
end

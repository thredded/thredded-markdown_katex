# frozen_string_literal: true

require 'thredded/markdown_katex/svg_allowlist'

module Thredded
  module MarkdownKatex
    # @deprecated use SVGAllowlist instead
    # TODO: drop when release 2.0
    module SVGWhitelist
      include SVGAllowlist
    end
  end
end

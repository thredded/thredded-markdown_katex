# frozen_string_literal: true

require 'thredded/markdown_katex/version'
require 'katex'
require 'thredded/markdown_katex/railtie' if defined?(Rails)
require 'thredded/markdown_katex/mathml_allowlist'
require 'thredded/markdown_katex/mathml_whitelist'
require 'thredded/markdown_katex/svg_allowlist'
require 'thredded/markdown_katex/svg_whitelist'
require 'thredded/markdown_katex/email_transformer'

module Thredded
  # Adds TeX math support to Thredded markdown via KaTeX.
  module MarkdownKatex
    @options = {
      math_engine: 'katex',
      math_engine_opts: {}
    }

    KRAMDOWN_FILTER_CLASS_NAME = 'Thredded::HtmlPipeline::KramdownFilter'

    class << self
      attr_reader :options

      def setup! # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        if pipeline_contains?(KRAMDOWN_FILTER_CLASS_NAME)
          # KaTeX engine for versions of Kramdown that do not have it built-in:
          if Gem::Version.new(Kramdown::VERSION) < Gem::Version.new('1.17.0')
            require 'thredded/markdown_katex/kramdown/katex_converter'
          else
            require 'kramdown-math-katex'
          end
          Thredded::HtmlPipeline::KramdownFilter.options.update(options)
        else
          raise "#{self.class.name} requires #{KRAMDOWN_FILTER_CLASS_NAME} " \
                'in Thredded::ContentFormatter.pipeline_filters'
        end

        configure_allowlist!

        Thredded::EmailTransformer.transformers <<
          Thredded::MarkdownKatex::EmailTransformer

        Thredded::FormattingDemoContent.parts.unshift File.read(
          File.join(File.dirname(__FILE__), 'markdown_katex', 'demo.md')
        )
      end

      private

      def pipeline_contains?(name)
        Thredded::ContentFormatter.pipeline_filters.map(&:name).include?(name)
      end

      def configure_allowlist!
        allowlist_katex_html!
        allowlist_mathml!
        allowlist_svg!
      end

      def allowlist_katex_html!
        allowlist_element! 'span', %w[class style aria-hidden]
        Thredded::ContentFormatter.allowlist[:css] ||= {}
        Thredded::ContentFormatter.allowlist[:css][:properties] ||= []
        Thredded::ContentFormatter.allowlist[:css][:properties] += %w[
          background-color border-color border-top-width border-right-width
          border-bottom-width color width min-width height min-height
          vertical-align padding-left margin-top margin-right margin-left
          font-size position top left bottom
        ]
      end

      def allowlist_mathml!
        MathMLAllowlist::PRESENTATION_ALLOWLIST.each do |tag, attrs|
          allowlist_element! tag, MathMLAllowlist::COMMON_ATT +
                                  MathMLAllowlist::COMMON_PRES_ATT + attrs
        end

        MathMLAllowlist::OTHER_ALLOWLIST.each do |tag, attrs|
          allowlist_element! tag, MathMLAllowlist::COMMON_ATT + attrs
        end
      end

      def allowlist_svg!
        attrs = SVGAllowlist::SVG_ATTRIBUTES.map(&:downcase)
        SVGAllowlist::SVG_ELEMENTS.each do |tag|
          allowlist_element! tag, attrs
        end
        Thredded::ContentFormatter.allowlist[:css][:properties] +=
          SVGAllowlist::SVG_ALLOWED_STYLE_PROPERTIES
      end

      def allowlist_element!(tag, attributes)
        allowlist_el = Thredded::ContentFormatter.allowlist[:elements]
        allowlist_el << tag unless allowlist_el.include?(tag)
        allowlist_attr = Thredded::ContentFormatter.allowlist[:attributes]
        allowlist_attr[tag] ||= []
        allowlist_attr[tag] += attributes
        allowlist_attr[tag].uniq!
      end
    end
  end
end

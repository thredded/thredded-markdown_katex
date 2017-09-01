# frozen_string_literal: true

require 'thredded/markdown_katex/version'
require 'katex'
require 'thredded/markdown_katex/railtie' if defined?(Rails)
require 'thredded/markdown_katex/mathml_whitelist'
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
          require 'thredded/markdown_katex/kramdown/katex_converter'
          Thredded::HtmlPipeline::KramdownFilter.options.update(options)
        else
          raise "#{self.class.name} requires #{KRAMDOWN_FILTER_CLASS_NAME} " \
                'in Thredded::ContentFormatter.pipeline_filters'
        end

        configure_whitelist!

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

      def configure_whitelist!
        whitelist_katex_html!
        whitelist_mathml!
        whitelist_svg!
      end

      def whitelist_katex_html!
        whitelist_element! 'span', %w[class style aria-hidden]
        Thredded::ContentFormatter.whitelist[:css] ||= {}
        Thredded::ContentFormatter.whitelist[:css][:properties] ||= []
        Thredded::ContentFormatter.whitelist[:css][:properties] += %w[
          background-color border-color color width min-width height min-height
          vertical-align margin-left margin-right font-size top
        ]
      end

      def whitelist_mathml!
        MathMLWhitelist::PRESENTATION_WHITELIST.each do |tag, attrs|
          whitelist_element! tag, MathMLWhitelist::COMMON_ATT +
                                  MathMLWhitelist::COMMON_PRES_ATT + attrs
        end

        MathMLWhitelist::OTHER_WHITELIST.each do |tag, attrs|
          whitelist_element! tag, MathMLWhitelist::COMMON_ATT + attrs
        end
      end

      def whitelist_svg!
        attrs = SVGWhitelist::SVG_ATTRIBUTES.map(&:downcase)
        SVGWhitelist::SVG_ELEMENTS.each do |tag|
          whitelist_element! tag, attrs
        end
        Thredded::ContentFormatter.whitelist[:css][:properties] +=
          SVGWhitelist::SVG_ALLOWED_STYLE_PROPERTIES
      end

      def whitelist_element!(tag, attributes)
        whitelist_el = Thredded::ContentFormatter.whitelist[:elements]
        whitelist_el << tag unless whitelist_el.include?(tag)
        whitelist_attr = Thredded::ContentFormatter.whitelist[:attributes]
        whitelist_attr[tag] ||= []
        whitelist_attr[tag] += attributes
        whitelist_attr[tag].uniq!
      end
    end
  end
end

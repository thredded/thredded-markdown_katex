# frozen_string_literal: true
require 'thredded/markdown_katex/version'
require 'katex'
require 'thredded/markdown_katex/railtie' if defined?(Rails)
require 'thredded/markdown_katex/mathml_whitelist'

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

      def setup!
        if pipeline_contains?(KRAMDOWN_FILTER_CLASS_NAME)
          require 'thredded/markdown_katex/kramdown/katex_converter'
          Thredded::HtmlPipeline::KramdownFilter.options.update(options)
        else
          raise "#{self.class.name} requires #{KRAMDOWN_FILTER_CLASS_NAME} " \
                'in Thredded::ContentFormatter.pipeline_filters'
        end

        configure_whitelist!
      end

      private

      def pipeline_contains?(name)
        Thredded::ContentFormatter.pipeline_filters.map(&:name).include?(name)
      end

      def configure_whitelist!
        whitelist_element! 'span', %w(class)

        MathMLWhitelist::PRESENTATION_WHITELIST.each do |tag, attrs|
          whitelist_element! tag, MathMLWhitelist::COMMON_ATT +
                                  MathMLWhitelist::COMMON_PRES_ATT + attrs
        end

        MathMLWhitelist::OTHER_WHITELIST.each do |tag, attrs|
          whitelist_element! tag, MathMLWhitelist::COMMON_ATT + attrs
        end
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

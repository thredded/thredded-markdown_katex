# frozen_string_literal: true

require 'thredded/email_transformer/base'
module Thredded
  module MarkdownKatex
    # Replaces Katex blocks with their `<math>` content and makes them visible,
    # because most email clients do not support webfonts, and webfonts are
    # required for the non-`<math>` version.
    class EmailTransformer < Thredded::EmailTransformer::Base
      def call
        doc.css('.katex').each do |katex|
          math = katex.at('math')
          math.remove_attribute('class')
          katex.swap math
        end
      end
    end
  end
end

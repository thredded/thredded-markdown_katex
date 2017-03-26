# frozen_string_literal: true

module Thredded
  module MarkdownKatex
    # Registers the thredded-markdown_katex initializer with Rails
    class Railtie < Rails::Railtie
      initializer 'thredded.markdown_katex', after: 'thredded' do
        Thredded::MarkdownKatex.setup!
      end
    end
  end
end

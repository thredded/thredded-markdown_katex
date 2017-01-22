# frozen_string_literal: true
module Thredded
  module MarkdownKatex
    class Railtie < Rails::Railtie
      initializer 'thredded.markdown_katex', after: 'thredded' do
        Thredded::MarkdownKatex.setup!
      end
    end
  end
end

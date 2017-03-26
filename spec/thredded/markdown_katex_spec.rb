# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Thredded::MarkdownKatex do
  it 'has a version number' do
    expect(Thredded::MarkdownKatex::VERSION).not_to be nil
  end

  it 'formats a $$ block' do
    markdown = <<~'MARKDOWN'
      $$
      Math!
      $$
    MARKDOWN
    expect(Thredded::ContentFormatter.new(nil).format_content(markdown))
      .to(start_with <<~HTML.chomp)
        <span class="katex-display"><span class="katex"><span class="katex-mathml">
    HTML
  end

  it 'transforms an email' do
    src = File.read(File.join(File.dirname(__FILE__), 'email.html'))
    doc = Nokogiri::HTML::Document.parse(src)
    Thredded::MarkdownKatex::EmailTransformer.call(doc)
    expect(doc.css('.katex')).to be_empty
    expect(doc.css('math')).to_not be_empty
  end
end

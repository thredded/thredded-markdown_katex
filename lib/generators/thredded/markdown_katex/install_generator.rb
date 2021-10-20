# frozen_string_literal: true

module Thredded
  module MarkdownKatex
    # Installs Thredded Katex plugin
    class InstallGenerator < Rails::Generators::Base
      desc 'Installs Thredded Katex plugin.'
      public_task :install

      def install
        %w[application.scss _deps.scss].each do |scss_file|
          scss_path = File.join('app', 'assets', 'stylesheets', scss_file)
          next unless File.exist? scss_path

          append_to_file scss_path, "\n@import \"_katex\";\n"
        end
        sass_path = 'app/assets/stylesheets/application.sass'
        append_to_file sass_path, "\n@import \"_katex\"\n" if File.exist? sass_path
        css_path = 'app/assets/stylesheets/application.css'
        append_to_file css_path, "\n//= require katex\n" if File.exist? css_path
      end
    end
  end
end

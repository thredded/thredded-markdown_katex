# frozen_string_literal: true
module Thredded
  module MarkdownKatex
    # Installs Thredded Katex plugin
    class InstallGenerator < Rails::Generators::Base
      desc 'Installs Thredded Katex plugin.'
      public_task :install

      def install # rubocop:disable Metrics/MethodLength
        scss_path = 'app/assets/stylesheets/application.scss'
        if File.exist? scss_path
          append_to_file scss_path, "\n" + '@import "_katex";' + "\n"
        end
        sass_path = 'app/assets/stylesheets/application.sass'
        if File.exist? sass_path
          append_to_file sass_path, "\n" + '@import "_katex"' + "\n"
        end
        css_path = 'app/assets/stylesheets/application.css'
        if File.exist? css_path # rubocop:disable Style/GuardClause
          append_to_file css_path, "\n" + '//= require katex' + "\n"
        end
      end
    end
  end
end

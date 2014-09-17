require 'swagger/thor/actions'

module Swagger
  module Thor
    class Generate < ::Thor::Group
      include ::Thor::Actions
      include Swagger::Thor::Actions

      argument :framework
      argument :name
      class_option :swagger_file, default: 'swagger.json'
      class_option :stub, type: :boolean, default: false, desc: 'Stub services with examples from Swagger'

      def self.source_root
        Swagger::Thor::TEMPLATE_DIR
      end

      def add_framework_to_source_root
        source_paths.map do | path |
          path << "/#{framework}"
        end
      end

      def set_destination_root
        self.destination_root = name
      end

      def load_helpers
        framework_root = source_paths.first
        Dir["#{framework_root}/helpers/**/*.rb"].each do |helper|
          load helper
        end
      end

      def parse_swagger_file
        @swagger = Swagger.load options[:swagger_file]
      end

      def copy_base_structure
        directory 'files', '.'
      end

      def bundle
        Bundler.with_clean_env do
          inside destination_root do
            run 'bundle install' if File.exist?('Gemfile')
          end
        end
      end
    end
  end
end

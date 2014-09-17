require 'swagger'
require 'swagger/thor/actions'

module Swagger
  module Thor
    class Convert < ::Thor::Group
      include ::Thor::Actions
      include Swagger::Thor::Actions

      argument :input_file
      argument :output_file, default: 'swagger.yaml'

      def setup # rubocop:disable Metrics/MethodLength
        type = File.extname input_file
        case type
        when '.yaml', '.yml'
          @old_swagger = YAML.load(File.read(input_file))
        when '.json'
          @old_swagger = JSON.parse(File.read(input_file))
        else
          fail "Cannot load #{input_file} - unknown file type"
        end

        @swagger_builder = Swagger::Builder.new(host: '')
        @swagger_builder.swagger = 1
        @swagger_builder.info do |info|
          info.license do |license|
            license.name = 'MIT'
          end
        end
        @swagger_builder.paths do |_paths|
        end

        puts JSON.pretty_generate(@swagger_builder.build)
      end
    end
  end
end

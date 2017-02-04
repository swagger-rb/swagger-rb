autoload :YAML, 'yaml'
autoload :JSON, 'json'

module Swagger
  # Provides classes for loading Swagger from YAML or JSON.
  module Parsers
    def self.parser_for(format)
      case format
      when '.yaml', '.yml', :yaml
        YAMLParser
      when '.json', '.js', :json
        JSONParser
      end
    end

    # Parses YAML content
    class YAMLParser
      # Parses a YAML document
      # @param content [String] The YAML content to parse
      # @return [Hash] the parsed content
      def self.parse(content)
        YAML.safe_load(content)
      end
    end

    # Parses JSON content
    class JSONParser
      # Parses a JSON document
      # @param content [String] The JSON content to parse
      # @return [Hash] the parsed content
      def self.parse(content)
        JSON.parse(content)
      end
    end
  end
end

autoload :YAML, 'yaml'
autoload :JSON, 'json'

module Swagger
  # Provides classes for loading Swagger from YAML or JSON.
  module Loaders
    def self.loader_for(ext)
      case ext
      when '.yaml', '.yml'
        YAMLLoader
      when '.json', '.js'
        JSONLoader
      else
        fail ArgumentError, "No registered Loader for #{ext}"
      end
    end

    # Loads a Swagger YAML document.
    class YAMLLoader
      def self.load(content)
        # Loads a Swagger YAML document.
        # @param content [String] The YAML content to load.
        # @return [API] a Swagger API object
        API.build(YAML.load(content))
      end
    end

    # Loads a Swagger JSON document.
    class JSONLoader
      # Loads a Swagger JSON document.
      # @param content [String] The JSON content to load.
      # @return [API] a Swagger API object
      def self.load(content)
        API.build(JSON.parse(content))
      end
    end
  end
end

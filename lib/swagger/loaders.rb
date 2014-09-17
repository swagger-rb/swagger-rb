autoload :YAML, 'yaml'
autoload :JSON, 'json'

module Swagger
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

    class YAMLLoader
      def self.load(content)
        APIDeclaration.build YAML.load(content)
      end
    end

    class JSONLoader
      def self.load(content)
        APIDeclaration.build JSON.parse(content)
      end
    end
  end
end

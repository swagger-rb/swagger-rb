require 'active_support/core_ext/string'

module Swagger
  module Thor
    module Actions
      def embed_file(source, indent = '')
        IO.read(File.join(self.class.source_root, source)).gsub(/^/, indent)
      end

      def embed_template(source, indent = '')
        template = File.join(self.class.source_root, source)
        template = "#{template}.tt" unless File.exist? template
        ERB.new(IO.read(template), nil, '-').result(binding).gsub(/^/, indent)
      end
    end
  end
end

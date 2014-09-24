require 'swagger/version'
require 'addressable/uri'
require 'addressable/template'
require 'hashie'

module Swagger
  RESOURCES_DIR = File.expand_path '../../resources/', __FILE__
  class InvalidDefinition < StandardError
    def initialize(errors)
      @errors = errors
      super("The Swagger definition is invalid. The following errors were detected: #{errors.inspect}")
    end
  end

  def self.load(file, loader = nil)
    ext = File.extname file
    loader ||= Swagger::Loaders.loader_for ext
    loader.load File.read(file)
  end
end

require 'swagger/attachable'
require 'swagger/definition_section'
require 'swagger/schema'
require 'swagger/uri'
require 'swagger/uri_template'
require 'swagger/loaders'
require 'swagger/mime_type'
require 'swagger/api_declaration'
require 'swagger/builder'

require 'swagger/version'
require 'addressable/uri'
require 'addressable/template'
require 'hashie'

# Provides loading and building capabilities for Swagger.
# @see http://swagger.io Swagger
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
require 'swagger/swagger_object'
require 'swagger/schema'
require 'swagger/uri'
require 'swagger/uri_template'
require 'swagger/loaders'
require 'swagger/mime_type'
require 'swagger/api'
require 'swagger/builder'

# Swagger

Swagger is a Ruby library for parsing, building, and traversing [Swagger](http://swagger.io/) API definitions.

[![Build Status](https://travis-ci.org/swagger-rb/swagger-rb.svg?branch=master)](https://travis-ci.org/swagger-rb/swagger-rb)

## WARNING

```diff
- WARNING: Swagger is currently locked to an old verison of Hashie.
- If you use this gem you may run into version compatiblity issues. Help is needed to resolve the issue (#19).
```

## Installation

*NOTE*: The gem is named `swagger-core`, because `swagger` was taken by an unrelated project.

Add this line to your application's Gemfile:

```ruby
gem 'swagger-core'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install swagger-core

## Features

- Structural and semantic validation of Swagger objects
- Convenient traversal APIs: use hierarchical or flat traversals
- Handles derived or combined properties, like joining root, path, and operation level property definitions
- A Swagger::Builder to help create valid Swagger documents from other data

## Usage

### Parsing

If you're loading a Swagger document from a file, you can use `#load`. The Swagger version will be detected from the file content.

```ruby
api = Swagger.load('swagger.yaml')
```

If you already have the Swagger content loaded as a Hash you can call build, or you can call
build and tell Swagger the content is a JSON or YAML string it needs to parse.

```ruby
api = Swagger.build(hash)
# or
api = Swagger.build(json, format: :json)
# or
api = Swagger.build(yaml, format: :yaml)
```

### Traversing

The parsing methods above all return an API object. The object has a hierarchical object that mirrors the Swagger specification. You can traverse it hierarchically, for example:

```ruby
api.paths['/pets'].get
# {"tags"=>["Pet Operations"],
# "summary"=>"finds pets in the system",
# "responses"=>
  {"200"=>{"description"=>"pet response", "schema"=>{"type"=>"array", "items"=>{"$ref"=>"#/definitions/Pet"}}, "headers"=>[{"x-expires"=>{"type"=>"string"}}]},
   "default"=>{"description"=>"unexpected error", "schema"=>{"$ref"=>"#/definitions/Error"}}}}
```

There are also methods available to provide flatter APIs or convenient derived properties. For example:

```ruby
api.operations.each do | operation |
  puts operation.signature
end
# GET petstore.swagger.wordnik.com/api/pets
# POST petstore.swagger.wordnik.com/api/pets
# GET petstore.swagger.wordnik.com/api/pets/{id}
# DELETE petstore.swagger.wordnik.com/api/pets/{id}
```

See the RDoc documentation for more details.

### Building

If you want to build a Swagger document from another structure, you can use the builder. It will validate the structure and data types as you build the Swagger document, but it won't enforce constraints about required Swagger fields until you call `Swagger::Builder#build`.

```ruby
builder = Swagger.builder
# or builder = Swagger.builder(version: '2.0')

builder.swagger = 2.0
builder.info do |info|
  info.title = 'Sample Swagger API'
  info.version = '1.0'
end
builder.paths = {
  '/foo' => {}
}
builder.paths['/foo'].get do |get|
  get.description = 'Testing...'
  get.tags = %w(foo bar)
end

api = builder.build
```

## TODO

* Support Swagger 1.2 - right now only Swagger 2.0 is supported
* Better handling of $ref
* Handle combined parameters, respones, etc

## Contributing

1. Fork it ( https://github.com/[my-github-username]/swagger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Run `git submodule update --init` locally to checkout the contents of [swagger_spec](swagger_spec).


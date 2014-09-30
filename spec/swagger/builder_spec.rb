require 'spec_helper'

module Swagger
  describe Builder do
    subject(:builder) { described_class.builder }
    describe 'setting fields' do
      it 'raises an error if the field does not exist' do
        expect { builder.xxx = 'foo' }.to raise_error(NoMethodError)
      end

      it 'raises if the value cannot be coerced to match the field' do
        expect { builder.swagger = :foo }.to raise_error(Hashie::CoercionError)
      end

      it 'sets the field' do
        expect { builder.swagger = 2.0 }.to change { builder.swagger }.from(nil).to(2.0)
      end

      it 'allows complex types to be set via a block' do
        builder.info do |info|
          info.title = 'Sample Swagger API'
          info.version = '1.0'
        end

        expect(builder.info).to be_an_kind_of(Swagger::Bash)
        expect(builder.info.title).to eq('Sample Swagger API')
      end
    end

    describe '#build' do
      it 'raises an error if a required field is omitted' do
        expect { builder.build }.to raise_error(ArgumentError, /property '\w+' is required/)
      end

      it 'returns the built Swagger API object if all required fields are present' do
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
        expect(builder.build).to be_an_instance_of(Swagger::V2::API)
      end
    end
  end
end

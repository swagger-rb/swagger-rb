require 'spec_helper'

RSpec.shared_examples 'swagger loading' do
  it { is_expected.to be_a_kind_of Swagger::API }

  it 'has a swagger spec version' do
    expect(subject.swagger).to eq('2.0')
  end
end

describe Swagger do
  describe '#build' do
    let(:content) { File.read(swagger_file) }

    context 'json' do
      let(:swagger_file) { 'swagger_spec/examples/v2.0/json/petstore.json' }
      let(:opts) do
        { format: :json }
      end
      subject(:swagger) { Swagger.build(content, opts) }
      include_examples 'swagger loading'
    end

    context 'yaml' do
      let(:swagger_file) { 'swagger_spec/examples/v2.0/yaml/petstore.yaml' }
      let(:opts) do
        { format: :yaml }
      end
      subject(:swagger) { Swagger.build(content, opts) }
      include_examples 'swagger loading'
    end

    context 'already parsed' do
      let(:swagger_file) { 'swagger_spec/examples/v2.0/yaml/petstore.yaml' }
      let(:content) { YAML.safe_load(File.read(swagger_file)) }
      subject(:swagger) { Swagger.build(content) }
      include_examples 'swagger loading'
    end
  end

  describe '#load' do
    subject(:swagger) { Swagger.load swagger_file }

    context 'json' do
      let(:swagger_file) { 'swagger_spec/examples/v2.0/json/petstore.json' }
      include_examples 'swagger loading'
    end

    context 'yaml' do
      let(:swagger_file) { 'swagger_spec/examples/v2.0/yaml/petstore.yaml' }
      include_examples 'swagger loading'
    end
  end

  describe '#builder' do
    context 'default version' do
      subject(:builder) { described_class.builder }
      it { is_expected.to be_a_kind_of(Swagger::Bash) }
      it { is_expected.to be_a_kind_of(Swagger::V2::API) }
    end

    context 'version 2' do
      subject(:builder) { described_class.builder(version: '2.0') }
      it { is_expected.to be_a_kind_of(Swagger::Bash) }
      it { is_expected.to be_a_kind_of(Swagger::V2::API) }
    end

    context 'version 1' do
      subject(:builder) { described_class.builder(version: '1.2') }
      pending { is_expected.to be_a_kind_of(Swagger::Bash) }
      pending { is_expected.to be_a_kind_of(Swagger::V2::API) }
    end
  end
end

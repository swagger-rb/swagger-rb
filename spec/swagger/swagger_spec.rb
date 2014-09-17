require 'spec_helper'

RSpec.shared_examples 'swagger loading' do
  it { is_expected.to be_a_kind_of Swagger::APIDeclaration }

  it 'has a swagger spec version' do
    expect(subject.swagger).to eq(2.0)
  end
end

describe Swagger do
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
end

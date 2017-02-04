describe Swagger do
  context 'vendor extensions' do
    let(:swagger_file) { 'spec/fixtures/bbc-1.0.0.yaml' }
    subject(:swagger) { Swagger.load(swagger_file) }

    it 'should support vendor extensions at various levels' do
      swagger
    end
  end
end

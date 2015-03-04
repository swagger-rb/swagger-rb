require 'spec_helper'

module Swagger
  module V2
    describe Path do
      subject(:path) { Path.new({}) }
      describe 'initial fields' do
        describe '#parameters' do
          subject { path.parameters }
          it { is_expected.to eq(nil) }
        end
      end
    end
  end
end

require_relative '../../lib/validates_subset'

module ActiveModel
  module Validations
    describe SubsetValidator do
      describe '#initialize' do
        let(:options) { { attributes: [:thing], foo: :bar, subset: [] } }
        subject { described_class.new(options) }

        it 'sets the options instance variable' do
          expect(subject.instance_variable_get(:@options)).to_not be_nil
        end

        it 'removes the attributes from the options' do
          expect(subject.instance_variable_get(:@options)).to_not have_key(:attributes)
        end

        it 'adds a message to the options' do
          expect(subject.instance_variable_get(:@options)).to have_key(:message)
          expect(subject.instance_variable_get(:@options)[:message]).to_not be_blank
        end
      end

      describe '#validate_each' do
      end
    end

    describe '.validate_subset' do
    end
  end
end

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
        let(:return_value) { nil }
        subject { described_class.new(attributes: [:foo]) }

        before do
          allow(subject).to receive(:is_subset?)          { return_value }
          allow(subject).to receive(:add_errors_or_raise) { nil }
        end

        it 'calls the validation logic' do
          expect(subject).to receive(:is_subset?)
          subject.validate_each(anything, anything, anything)
        end

        context 'validation passes' do
          let(:return_value) { true }

          it 'does not add errors on the validated model' do
            expect(subject).to_not receive(:add_errors_or_raise)
            subject.validate_each(anything, anything, anything)
          end

          it 'does not throw any errors' do
            expect do
              subject.validate_each(anything, anything, anything)
            end.to_not raise_error
          end
        end

        context 'validation fails' do
          let(:return_value) { false }

          it 'adds values to the errors on the validated model' do
            expect(subject).to receive(:add_errors_or_raise)
            subject.validate_each(anything, anything, anything)
          end
        end
      end
    end

    describe '.validate_subset' do
      class IncludedClass
        include ActiveModel::Validations
      end

      it 'validates with SubsetValidator' do
        included_class = IncludedClass
        expect(included_class).to receive(:validates_with)
          .with(SubsetValidator, anything)
        included_class.validates_subset(anything, anything)
      end
    end
  end
end

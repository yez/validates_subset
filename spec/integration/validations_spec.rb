# frozen_string_literal: true

require_relative '../../lib/validates_subset'

class ActiveModelTestClass
  include ActiveModel::Validations

  attr_accessor :foo

  validates_subset :foo, [1, 2, 3]

  def initialize(foo)
    @foo = foo
  end
end

describe ValidatesSubset do
  subject { ActiveModelTestClass.new(attribute_value) }

  context 'attribute is a valid subset' do
    let(:attribute_value) { [1, 2] }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'attribute is not a valid subset' do
    context 'value is still an array' do
      let(:attribute_value) { [5, 6] }

      it 'does not error' do
        expect do
          subject.validate
        end.to_not raise_error
      end

      it 'is not valid' do
        expect(subject).to_not be_valid
      end

      it 'has an error message with the key of the validated attribute' do
        subject.validate
        expect(subject.errors).to have_key(:foo)
      end
    end
  end
end

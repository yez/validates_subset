# frozen_string_literal: true

require_relative '../../../lib/validates_subset'

class TestMultiple
  include ActiveModel::Validations

  attr_accessor :foo

  validates_subset :foo, [1, 2, 3], allow_blank: true, message: 'oh no spaghettios'
end

describe 'multiple validations' do
  subject do
    sub = TestMultiple.new
    sub.foo = value
    sub
  end

  context 'value is not blank' do
    context 'value is a valid subset' do
      let(:value) { [1] }

      specify do
        expect(subject).to be_valid
      end
    end

    context 'value is not a valid subset' do
      let(:value) { %i[a b c] }

      specify do
        expect(subject).to_not be_valid
      end

      it 'has the specified error message' do
        subject.validate
        expect(subject.errors.full_messages.to_s).to match(/oh no spaghettios/)
      end
    end

    context 'value is not an array' do
      let(:value) { 'bar' }

      specify do
        expect(subject).to_not be_valid
      end

      it 'has the specified error message' do
        subject.validate
        expect(subject.errors.full_messages.to_s).to match(/oh no spaghettios/)
      end
    end
  end

  context 'value is blank' do
    let(:value) { nil }

    specify do
      expect(subject).to be_valid
    end

    context 'an empty array' do
      let(:value) { [] }

      specify do
        expect(subject).to be_valid
      end
    end

    context 'an empty hash' do
      let(:value) { {} }

      specify do
        expect(subject).to be_valid
      end
    end
  end
end

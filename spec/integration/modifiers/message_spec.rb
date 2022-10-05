# frozen_string_literal: true

require_relative '../../../lib/validates_subset'

class TestMessage
  include ActiveModel::Validations

  attr_accessor :foo

  validates_subset :foo, [1, 2, 3], message: 'Oh no spaghettios'
end

describe 'custom messaging' do
  subject do
    sub = TestMessage.new
    sub.foo = value
    sub
  end

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

    it 'sets the custom error message' do
      subject.validate
      expect(subject.errors[:foo].first).to match(/Oh no spaghettios/)
    end
  end

  context 'value is not an array' do
    let(:value) { 'bar' }

    specify do
      expect(subject).to_not be_valid
    end

    it 'sets the custom error message' do
      subject.validate
      expect(subject.errors[:foo].first).to match(/Oh no spaghettios/)
    end
  end
end

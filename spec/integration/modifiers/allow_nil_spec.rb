require_relative '../../../lib/validates_subset'

class TestAllowNil
  include ActiveModel::Validations

  attr_accessor :foo

  validates_subset :foo, [1, 2, 3], allow_nil: true
end

describe 'allow nil' do
  subject { sub = TestAllowNil.new; sub.foo = value; sub }

  context 'value is not nil' do
    context 'value is a valid subset' do
      let(:value) { [1] }

      specify do
        expect(subject).to be_valid
      end
    end

    context 'value is not a valid subset' do
      let(:value) { [:a, :b, :c] }

      specify do
        expect(subject).to_not be_valid
      end
    end

    context 'value is not an array' do
      let(:value) { 'bar' }

      specify do
        expect(subject).to_not be_valid
      end
    end
  end

  context 'value is nil' do
    let(:value) { nil }

    specify do
      expect(subject).to be_valid
    end
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
      expect(subject).to_not be_valid
    end
  end
end

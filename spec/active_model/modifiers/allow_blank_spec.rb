require_relative '../../../lib/validates_subset'

class TestAllowBlank
  include ActiveModel::Validations

  attr_accessor :foo

  validates_subset :foo, [1, 2, 3], allow_blank: true
end

describe 'allow blank' do
  subject { sub = TestAllowBlank.new; sub.foo = value; sub }

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
    end

    context 'value is not an array' do
      let(:value) { 'bar' }

      specify do
        expect(subject).to_not be_valid
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

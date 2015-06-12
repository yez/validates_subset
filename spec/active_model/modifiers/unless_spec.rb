require_relative '../../../lib/validates_subset'

describe 'unless condition' do
  subject { sub = TestIfTrue.new; sub.foo = value; sub }

  context 'if condition results in true' do

    class TestIfTrue
      include ActiveModel::Validations

      attr_accessor :foo

      validates_subset :foo, [1, 2, 3], unless: -> { true }
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
        expect(subject).to be_valid
      end
    end

    context 'value is not an array' do
      let(:value) { 'bar' }

      specify do
        expect(subject).to be_valid
      end
    end
  end

  context 'condition results is not true' do
    class TestIfFalse
      include ActiveModel::Validations

      attr_accessor :foo

      validates_subset :foo, [1, 2, 3], unless: -> { false }
    end

    subject { sub = TestIfFalse.new; sub.foo = value; sub }

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
end

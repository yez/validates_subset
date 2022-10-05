# frozen_string_literal: true

require_relative '../../../lib/validates_subset'

describe 'strict' do
  context 'default exception for strict validation' do
    class TestStrictDefault
      include ActiveModel::Validations

      attr_accessor :foo

      validates_subset :foo, [1, 2, 3], strict: true
    end

    subject do
      sub = TestStrictDefault.new
      sub.foo = value
      sub
    end

    context 'input is valid' do
      let(:value) { [1] }

      it 'is valid' do
        expect(subject).to be_valid
      end

      it 'does not raise any errors' do
        expect do
          subject.valid?
        end.to_not raise_error
      end
    end

    context 'input is invalid' do
      let(:value) { 'banana' }

      it 'raises an error' do
        expect do
          subject.valid?
        end.to raise_error
      end
    end
  end

  context 'specific exception for strict validation' do
    class TestStrictSpecific
      class SomeStrictError < StandardError; end

      include ActiveModel::Validations

      attr_accessor :foo

      validates_subset :foo, [1, 2, 3], strict: SomeStrictError
    end

    subject do
      sub = TestStrictSpecific.new
      sub.foo = value
      sub
    end

    context 'input is valid' do
      let(:value) { [1] }

      it 'is valid' do
        expect(subject).to be_valid
      end

      it 'does not raise any errors' do
        expect do
          subject.valid?
        end.to_not raise_error
      end
    end

    context 'input is invalid' do
      let(:value) { 'banana' }

      it 'raises the custom error' do
        expect do
          subject.valid?
        end.to raise_error(TestStrictSpecific::SomeStrictError)
      end
    end
  end
end

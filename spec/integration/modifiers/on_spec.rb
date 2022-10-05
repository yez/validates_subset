# frozen_string_literal: true

require_relative '../../../lib/validates_subset'

describe 'on' do
  class TestOn
    include ActiveModel::Validations

    attr_accessor :foo

    validates_subset :foo, [1, 2, 3], on: :special_method

    def special_method; end
  end

  subject do
    sub = TestOn.new
    sub.foo = value
    sub
  end

  it 'adds the options to the validation' do
    options = TestOn.validators_on(:foo).first.options
    expect(options).to include(:on)
    expect(options[:on]).to eq(:special_method)
  end
end

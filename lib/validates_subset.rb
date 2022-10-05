# frozen_string_literal: true

require 'active_model'
require 'active_support/i18n'

I18n.load_path << "#{File.dirname(__FILE__)}/../locale/en.yml"
I18n.load_path << "#{File.dirname(__FILE__)}/../locale/pl.yml"
I18n.load_path << "#{File.dirname(__FILE__)}/../locale/sv.yml"

require_relative './arguments'

module ActiveModel
  module Validations
    class SubsetValidator < ActiveModel::EachValidator
      # @initialize
      #   param: options <Hash> - options hash of how to validate this attribute
      #                           including custom messaging due to failures, specifying
      #                           the subset the attribute to validate against, etc.
      #   return: result of ActiveModel::Validations::EachValidator initialize
      def initialize(options)
        options[:superset] = options.delete(:subset)

        merged_options = {
          message: :subset
        }.merge(options)

        super(merged_options)
      end

      # Validate that the array is a subset of what we expect
      #
      # @validate_each
      #   param: record <Object>    - subject containing attribute to validate
      #   param: attribute <Symbol> - name of attribute to validate
      #   param: value <Variable>   - value of attribute to validate
      #   return: nil
      def validate_each(record, attribute, value)
        add_errors_or_raise(options, record, attribute) unless subset?(value, options[:superset])
      end

      private

      def subset?(set, superset)
        set.is_a?(Array) && (set & superset) == set
      end

      # Helper method to either add messages to the errors object
      # or raise an exception in :strict mode
      #
      # @add_errors_or_raise
      #   param: options <Hash>     - options hash with strict flag or class
      #   param: record <Object>    - subject containg attribute to validate
      #   param: attribute <Symbol> - name of attribute under validation
      #   return: nil
      def add_errors_or_raise(options, record, attribute)
        error = options_error(options[:strict])

        raise error unless error.nil?

        value = record.send(attribute)

        invalid_value = if value.is_a?(Array)
                          value - options[:superset]
                        else
                          value
                        end

        error_options = { subset: options[:superset], invalid_value: invalid_value }.merge(message: options[:message])
        record.errors.add(attribute, :subset, error_options)
      end

      # Helper method to return the base expected error:
      # ActiveModel::StrictValidationFailed, a custom error, or nil
      #
      # @options_error
      #   param: strict_error <true or subclass of Exception> - either the flag
      #           to raise an error or the actual error to raise
      #   return: custom error, ActiveModel::StrictValidationFailed, or nil
      def options_error(strict_error)
        return if strict_error.nil?

        if strict_error == true
          ActiveModel::StrictValidationFailed
        elsif strict_error.ancestors.include?(Exception)
          strict_error
        end
      end
    end

    module ClassMethods
      # Validates that an attribute is a subset of an expected set:
      #
      # class Foo
      #   include ActiveModel::Validations
      #
      #   attr_accessor :thing, :something
      #
      #   validates_subset :thing, ['something', 'another thing', 'a third thing']
      #   validates_subset :something, [:foo, :bar]
      # end
      #
      # @validates_subset
      #   param: attribute_name <Symbol> - name of attribute to validate
      #   param: set <Array>             - superset of all desired members
      #   param: options <Hash>          - other common options to validate methods calls
      #                                    i.e. message: 'my custom error message'
      #   return: nil
      def validates_subset(attribute_name, superset, options = {})
        args = ValidatesSubset::Arguments.new(attribute_name, superset, options)
        validates_with SubsetValidator, _merge_attributes(args.to_validation_attributes)
      end
    end
  end
end

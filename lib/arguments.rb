module ValidatesSubset
  # Wrapper class for arguments consumed by validates_with
  class Arguments
    # @initialize
    #   param: attribute_name <Symbol> - Name of attribute that will be validated
    #   param: superset <Array>        - Superset of attributes to validate set against
    #   param: options <Hash>          - Extra options to pass along to the validator
    #                                    i.e. allow_nil: true, message: 'my custom message'
    #   return: nil
    def initialize(attribute_name, superset, options)
      @attribute_name = attribute_name
      @superset       = superset
      @options        = options.is_a?(Hash) ? options : {}
    end

    # format expected by _merge_attributes
    #
    # @to_validation_attributes
    # return: <Array> - cardinality of 2
    def to_validation_attributes
      [@attribute_name, merged_options]
    end

    private

    # helper method to compact all the options together along
    #   with the subset for validation
    #
    # @merged_options
    #   return: <Hash>
    def merged_options
      subset.merge(@options)
    end

    # helper method to impose the subset for validation into an option
    #  that will be merged later
    #
    # @subset
    #   return: <Hash>
    def subset
      { subset: @superset }
    end
  end
end

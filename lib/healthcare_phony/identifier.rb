# frozen_string_literal: true

require 'regexp-examples'

module HealthcarePhony
  class Identifier
    attr_accessor :identifier,
                  :assigning_authority,
                  :identifier_type_code

    def initialize(**init_args)
      @identifier_type_code = init_args[:type_code].nil? ? '' : init_args[:type_code]

      identifier_pattern = init_args[:pattern].nil? ? '\d{10}' : init_args[:pattern]

      @identifier = Regexp.new(identifier_pattern).random_example
    end
  end
end

# frozen_string_literal: true

require 'regexp-examples'

module HealthcarePhony
  # Public: Randomly generates an identifier.
  class Identifier
    attr_accessor :identifier,
                  :identifier_type_code

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # type_code - Identifier Type Code, example PID.3.5.  HL7 Data Table 0203
    # pattern - Regex pattern used to randomly generate the identifier.  Default is \d{10} which would generate an
    # identifier like 5992657933.
    def initialize(init_args = {})
      @identifier_type_code = init_args[:type_code].nil? ? '' : init_args[:type_code]

      identifier_pattern = init_args[:pattern].nil? ? '\d{10}' : init_args[:pattern]

      @identifier = Regexp.new(identifier_pattern).random_example
    end
  end
end

# frozen_string_literal: true

require File.expand_path('phone_number', __dir__)

module HealthcarePhony
  # Public: Generates a fake home phone number
  class HomePhoneNumber < PhoneNumber
    # Public: Initializes a home phone number. Pass in hash of different parameters, currently this includes:
    # blank - An integer representing the % of times phone number components should be blank.
    # use_code - Allows specification of the phone use code (PID.13.2)
    # equipment_type - Allows specification of the phone equipment type (PID.13.3)
    def initialize(init_args = {})
      super(init_args)
      @use_code = init_args[:use_code].nil? ? 'PRN' : init_args[:use_code]
      @use_code = '' unless @set_blank == false
      @equipment_type = init_args[:equipment_type].nil? ? 'PH' : init_args[:equipment_type]
      @equipment_type = '' unless @set_blank == false
    end
  end
end

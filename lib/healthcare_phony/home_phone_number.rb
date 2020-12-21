# frozen_string_literal: true

require File.expand_path('phone_number', __dir__)

module HealthcarePhony
  class HomePhoneNumber < PhoneNumber
    def initialize(**init_args)
      super(init_args)
      @use_code = if init_args[:use_code].nil?
                    'PRN'
                  else
                    init_args[:use_code]
                  end
      @equipment_type = init_args[:equipment_type].nil? ? 'PH' : init_args[:equipment_type]
    end
  end
end

# frozen_string_literal: true

require File.expand_path('phone_number', __dir__)

module HealthcarePhony
  class WorkPhoneNumber < PhoneNumber
    def initialize(**init_args)
      super(init_args)
      @use_code = init_args[:use_code].nil? ? 'WPN' : init_args[:use_code]
      @equipment_type = init_args[:equipment_type].nil? ? 'PH' : init_args[:equipment_type]
    end
  end
end

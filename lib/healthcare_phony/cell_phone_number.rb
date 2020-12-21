# frozen_string_literal: true

require File.expand_path('phone_number', __dir__)

module HealthcarePhony
  class CellPhoneNumber < PhoneNumber
    def initialize(**init_args)
      super(init_args)
      @use_code = init_args[:use_code].nil? ? 'ORN' : init_args[:use_code]
      @equipment_type = init_args[:equipment_type].nil? ? 'CP' : init_args[:equipment_type]
    end
  end
end

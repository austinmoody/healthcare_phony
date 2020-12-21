# frozen_string_literal: true

module HealthcarePhony
  class Email
    attr_accessor :email,
                  :use_code,
                  :equipment_type

    def initialize(**init_args)
      @email_address = Faker::Internet.email

      @email_address = Helper.random_with_blank(@email_address, init_args[:blank]) unless init_args[:blank].nil?

      @use_code = @email_address == '' ? '' : 'NET'
      @equipment_type = @email_address == '' ? '' : 'X.400'
    end
  end
end

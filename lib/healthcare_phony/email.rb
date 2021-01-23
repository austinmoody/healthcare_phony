# frozen_string_literal: true

module HealthcarePhony
  # Public: Generate a fake email address
  class Email
    attr_accessor :email_address,
                  :use_code,
                  :equipment_type

    def initialize(init_args = {})
      @set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      @email_address = Faker::Internet.email
      @email_address = '' unless @set_blank == false
      @use_code = @email_address == '' ? '' : 'NET'
      @use_code = '' unless @set_blank == false
      @equipment_type = @email_address == '' ? '' : 'X.400'
      @equipment_type = '' unless @set_blank == false
    end

    private

    # Private: Boolean set during initialization if Address components should be set to blank.
    attr_accessor :set_blank
  end
end

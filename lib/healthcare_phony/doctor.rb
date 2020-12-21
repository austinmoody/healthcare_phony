# frozen_string_literal: true

module HealthcarePhony
  class Doctor
    attr_accessor :identifier,
                  :name

    def initialize(**init_args)
      @identifier = if !init_args[:identifier].nil?
                      init_args[:identifier]
                    else
                      pre_check_npi = /1[0-9]{8}/.random_example.to_i
                      (pre_check_npi.to_s + Helper.get_npi_check_digit(pre_check_npi).to_s).to_i
                    end

      @name = PersonName.new(degree: 'MD,DO')
    end
  end
end

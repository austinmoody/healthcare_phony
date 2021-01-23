# frozen_string_literal: true

module HealthcarePhony
  # Public: Generates a fake Doctor
  class Doctor
    # Public: Gets/Sets the String identifier of the doctor.
    attr_accessor :identifier
    # Public: Gets/Sets the PersonName name of the doctor.
    attr_accessor :name

    # Public: Initialize a Doctor.  Pass in hash of different parameters, currently this includes:
    #
    # identifier - Allows you to specify an identifier for this Doctor instead of having it randomly generated.
    def initialize(init_args = {})
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

# frozen_string_literal: true

module HealthcarePhony
  # Public: Creates admission information for a patient visit.
  class VisitAdmission
    attr_accessor :type, :datetime, :source, :reason

    # Public: Initializes an EthnicGroup. Pass in hash of different parameters, currently this includes:
    # admit_source - Array of Admit Source codes (PV1.14) to randomly choose from.  Specified as comma separated
    # String or Ruby array. Otherwise default HL7 v2.5.1 Table 0023 values are used.
    # admission_type - Array of Admission Type (PV1.4) to randomly choose from.  Specified as comma separated String or
    # Ruby array. Otherwise default HL7 v2.5.1. Table 0007 values are used.
    # admit_reason - Array of values to use as Admit Reason (PV2.3) to randomly choose from.  Specified as comma
    # separated String or Ruby array.  Otherwise a string of data is generated with Faker::Lorem.sentence
    def initialize(init_args = {})
      @source = define_source(init_args)
      @type = define_type(init_args)
      @datetime = Faker::Time.backward(days: Faker::Number.number(digits: 1))
      @reason = define_reason(init_args)
    end

    private

    def define_source(init_args = {})
      standard_admit_source = '123456789'.split('')
      as_choices = Helper.get_array(init_args[:admit_source])
      if !as_choices.empty?
        as_choices.sample
      else
        standard_admit_source.sample
      end
    end

    def define_type(init_args = {})
      standard_admission_types = %w[A C E L N R U]
      at_choices = Helper.get_array(init_args[:admission_type])
      if !at_choices.empty?
        at_choices.sample
      else
        standard_admission_types.sample
      end
    end

    def define_reason(init_args = {})
      ar_choices = Helper.get_array(init_args[:admit_reason])
      if !ar_choices.empty?
        ar_choices.sample
      else
        Faker::Lorem.sentence
      end
    end
  end
end

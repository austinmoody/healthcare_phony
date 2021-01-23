# frozen_string_literal: true

module HealthcarePhony
  # Public: Randomly generates data for a PatientVisit (PV1 segment)
  class PatientVisit
    attr_accessor :patient_class,
                  :admission, :doctors,
                  :hospital_service, :readmission_indicator,
                  :ambulatory_status, :vip_indicator, :patient_type,
                  :visit_number, :bed_status,
                  :discharge, :location

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # hospital_service - Array of Hospital Service codes (PV1.10) to randomly choose from.  Specified as comma separated
    # String or Ruby array. Otherwise default HL7 v2.5.1 Table 0069 values are used.
    # patient_class - Array of Patient Class codes (PV1.2) to randomly choose from.  Specified as comma separated
    # String or Ruby array. Otherwise default HL7 v2.5.1 Table 0004 values are used.
    # ambulatory_status - Array of Ambulatory Status codes (PV1.15) to randomly choose from. Specified as comma
    # separated String or Ruby array. Otherwise default HL7 v2.5.1 Table 0009 values are used.
    # bed_status - Array of Bed Status codes (PV1.40) to randomly choose from. Specified as comma separated String or
    # Ruby array.  Otherwise default HL7 v2.5.1 Table 0116 values are used.
    # patient_type - Array of Patient Type codes (PV1.18) to randomly choose from. Specified as comma separated String
    # or Ruby array. Otherwise this field is left blank.
    # vip_indicator - Array of Patient Type codes (PV1.18) to randomly choose from. Specified as comma separated String
    # or Ruby array. Otherwise this field is left blank.
    def initialize(init_args = {})
      @doctors = VisitDoctors.new
      @location = VisitLocation.new(init_args)
      @admission = VisitAdmission.new(init_args)
      @bed_status = define_bed_status(init_args)
      @visit_number = Identifier.new(type_code: 'VN')
      @readmission_indicator = Helper.random_with_blank('R', 50)
      @patient_type = define_patient_type(init_args)
      @vip_indicator = define_vip(init_args)
      @ambulatory_status = define_ambulatory_status(init_args)
      @patient_class = define_patient_class(init_args)
      @hospital_service = define_hospital_service(init_args)
      @discharge = VisitDischarge.new(init_args.merge({ admit_datetime: @admission.datetime }))
    end

    private

    def define_hospital_service(init_args = {})
      standard_hospital_service = %w[CAR MED PUL SUR URO]
      hs_choices = Helper.get_array(init_args[:hospital_service])
      if !hs_choices.empty?
        hs_choices.sample
      else
        standard_hospital_service.sample
      end
    end

    def define_patient_class(init_args = {})
      standard_pc_choices = %w[B C E I N O P R U]
      pc_choices = Helper.get_array(init_args[:patient_class])
      !pc_choices.empty? ? pc_choices.sample : standard_pc_choices.sample
    end

    def define_ambulatory_status(init_args = {})
      standard_ambulatory_status = %w[A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 B1 B2 B3 B4 B5 B6]
      as_choices = Helper.get_array(init_args[:ambulatory_status])
      if !as_choices.empty?
        as_choices.sample
      else
        standard_ambulatory_status.sample
      end
    end

    def define_bed_status(init_args = {})
      bs_choices = Helper.get_array(init_args[:bed_status])
      if !bs_choices.empty?
        bs_choices.sample
      else
        %w[C H I K O U].sample
      end
    end

    def define_patient_type(init_args = {})
      pt_choices = Helper.get_array(init_args[:patient_type])
      if !pt_choices.empty?
        pt_choices.sample
      else
        ''
      end
    end

    def define_vip(init_args = {})
      vip_choices = Helper.get_array(init_args[:vip_indicator])
      if !vip_choices.empty?
        vip_choices.sample
      else
        ''
      end
    end
  end
end

# frozen_string_literal: true

require 'test_helper'

class PatientVisitTest < Minitest::Test
  def setup
    setup_default
    setup_specified_values
  end

  def setup_default
    @valid_hospital_service = %w[CAR MED PUL SUR URO]
    @valid_patient_classes = %w[B C E I N O P R U]
    @valid_ambulatory_statuses = %w[A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 B1 B2 B3 B4 B5 B6]
    @valid_bed_statuses = %w[C H I K O U]
    @pv_default = HealthcarePhony::PatientVisit.new
  end

  def setup_specified_values
    @different_codes = 'ABC,123,ZZZ,098'
    @pv_different = HealthcarePhony::PatientVisit.new(hospital_service: @different_codes,
                                                      patient_class: @different_codes,
                                                      ambulatory_status: @different_codes,
                                                      bed_status: @different_codes)
  end

  def test_default_values
    assert_includes(@valid_hospital_service, @pv_default.hospital_service)
    assert_includes(@valid_patient_classes, @pv_default.patient_class)
    assert_includes(@valid_ambulatory_statuses, @pv_default.ambulatory_status)
    assert_includes(@valid_bed_statuses, @pv_default.bed_status)
    assert_equal('', @pv_default.patient_type)
    assert_equal('', @pv_default.vip_indicator)
    assert_includes(['', 'R'], @pv_default.readmission_indicator)
  end

  def test_default_doctors
    assert_kind_of(HealthcarePhony::Doctor, @pv_default.doctors.attending)
    assert_kind_of(HealthcarePhony::Doctor, @pv_default.doctors.referring)
    assert_kind_of(HealthcarePhony::Doctor, @pv_default.doctors.consulting)
    assert_kind_of(HealthcarePhony::Doctor, @pv_default.doctors.admitting)
  end

  def test_specified_values
    assert_includes(@different_codes.split(','), @pv_different.hospital_service)
    assert_includes(@different_codes.split(','), @pv_different.ambulatory_status)
    assert_includes(@different_codes.split(','), @pv_different.bed_status)
    assert_includes(@different_codes.split(','), @pv_different.patient_class)
  end
end

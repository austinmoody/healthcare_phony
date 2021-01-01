# frozen_string_literal: true

require 'test_helper'

class VisitAdmissionTest < Minitest::Test
  def setup
    setup_default
  end

  def setup_default
    @valid_admit_source = '123456789'.split('')
    @valid_admission_types = %w[A C E L N R U]
  end

  def test_default
    va = HealthcarePhony::VisitAdmission.new
    assert_includes(@valid_admit_source, va.source)
    assert_includes(@valid_admission_types, va.type)
    assert_match(/[a-zA-Z. ]/, va.reason)
  end

  def test_datetime
    va = HealthcarePhony::VisitAdmission.new
    assert(va.datetime <= Time.now)
    assert(va.datetime >= (Time.now - 9 * 24 * 60 * 60))
  end

  def test_admit_source_string
    admit_source_string = 'ABC,123,ZZZ'
    va = HealthcarePhony::VisitAdmission.new(admit_source: admit_source_string)
    assert_includes(admit_source_string.split(','), va.source)
  end

  def test_admit_source_array
    admit_source_array = %w[ABC 123 ZZZ 098]
    va = HealthcarePhony::VisitAdmission.new(admit_source: admit_source_array)
    assert_includes(admit_source_array, va.source)
  end

  def test_types_string
    types_string = 'ABC,123,ZZZ,098'
    va = HealthcarePhony::VisitAdmission.new(admission_type: types_string)
    assert_includes(types_string.split(','), va.type)
  end

  def test_types_array
    types_array = %w[ABC 123 ZZZ 098]
    va = HealthcarePhony::VisitAdmission.new(admission_type: types_array)
    assert_includes(types_array, va.type)
  end

  def test_reason_string
    reason_string = 'abd pain,BLEEDING ON KNEE,NAUSEA/VOMITING,R30.9,CARDIOVASCULAR DISEASE'
    va = HealthcarePhony::VisitAdmission.new(admit_reason: reason_string)
    assert_includes(reason_string.split(','), va.reason)
  end

  def test_reason_array
    reason_array = ['abd pain', 'BLEEDING ON KNEE', 'NAUSEA/VOMITING', 'R30.9', 'CARDIOVASCULAR DISEASE']
    va = HealthcarePhony::VisitAdmission.new(admit_reason: reason_array)
    assert_includes(reason_array, va.reason)
  end
end

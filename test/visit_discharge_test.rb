# frozen_string_literal: true

require 'test_helper'

class VisitDischargeTest < Minitest::Test
  def setup
    read_discharge_disposition
  end

  def read_discharge_disposition
    # Read in default YAML file, create arrays to compare against
    file_join = ::File.join('../..', 'lib', 'healthcare_phony', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/discharge_disposition.yml"
    @dispositions = Psych.load_file(data_file)
  end

  def test_default_init
    vd = HealthcarePhony::VisitDischarge.new
    assert_equal('', vd.disposition)
    assert_equal('', vd.location)
    assert_nil(vd.datetime)
  end

  def test_default_a03
    vd = HealthcarePhony::VisitDischarge.new(event_type: 'A03')
    assert_includes(@dispositions, vd.disposition)
    assert_match(/[a-zA-Z. ]/, vd.location)
    assert(vd.datetime < Time.now)
  end

  def test_disposition_set_string
    discharge_disposition = 'ABC,123,ZZZ'
    vd = HealthcarePhony::VisitDischarge.new(event_type: 'A03', discharge_disposition: discharge_disposition)
    assert_includes(discharge_disposition.split(','), vd.disposition)
  end

  def test_disposition_set_array
    discharge_disposition = %w[ABC 123 ZZZ]
    vd = HealthcarePhony::VisitDischarge.new(event_type: 'A03', discharge_disposition: discharge_disposition)
    assert_includes(discharge_disposition, vd.disposition)
  end

  def test_location_set_string
    locations = 'Hospital A, Clinic Z'
    vd = HealthcarePhony::VisitDischarge.new(event_type: 'A03', discharge_location: locations)
    assert_includes(locations.split(','), vd.location)
  end

  def test_location_set_array
    locations = ['Hospital A', 'Clinic Z']
    vd = HealthcarePhony::VisitDischarge.new(event_type: 'A03', discharge_location: locations)
    assert_includes(locations, vd.location)
  end

  def test_set_datetime
    admit_datetime = Time.now - 9 * 24 * 60 * 60
    vd = HealthcarePhony::VisitDischarge.new(event_type: 'A03', admit_datetime: admit_datetime)
    assert(vd.datetime > admit_datetime)
  end
end

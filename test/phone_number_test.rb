# frozen_string_literal: true

require 'test_helper'

class PhoneNumberTest < Minitest::Test
  def setup
    @default_use_codes = read_default_use_codes
    @default_type_codes = read_default_type_codes
    @phone_test_file = phone_test_file
    @different_codes = read_phone_test_values(@phone_test_file)
  end

  def read_default_use_codes
    file_join = ::File.join('../..', 'lib', 'healthcare_phony', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/tele_use_code.yml"
    Psych.load_file(data_file)
  end

  def read_default_type_codes
    file_join = ::File.join('../..', 'lib', 'healthcare_phony', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/tele_equipment_type.yml"
    Psych.load_file(data_file)
  end

  def phone_test_file
    file_join = ::File.join('..', 'data_files')
    "#{::File.expand_path(file_join, __FILE__)}/phone_test.yml"
  end

  def read_phone_test_values(data_file)
    Psych.load_file(data_file)
  end

  def test_default
    p_default = HealthcarePhony::PhoneNumber.new
    assert_equal('++1', p_default.country_code)
    assert_match(/[0-9]{3}/, p_default.area_code)
    assert_match(/[0-9]{3}/, p_default.exchange_code)
    assert_match(/[0-9]{4}/, p_default.subscriber_number)
    assert_includes(@default_use_codes, p_default.use_code)
    assert_includes(@default_type_codes, p_default.equipment_type)
  end

  def test_blank
    p_blank = HealthcarePhony::PhoneNumber.new(blank: 100)
    assert_equal('', p_blank.country_code)
    assert_equal('', p_blank.area_code)
    assert_equal('', p_blank.exchange_code)
    assert_equal('', p_blank.subscriber_number)
    assert_equal('', p_blank.use_code)
    assert_equal('', p_blank.equipment_type)
  end

  def test_different_files
    p_diff = HealthcarePhony::PhoneNumber.new(use_code_data_file: @phone_test_file,
                                              equipment_type_data_file: @phone_test_file)
    assert_includes(@different_codes, p_diff.use_code)
    assert_includes(@different_codes, p_diff.equipment_type)
  end
end

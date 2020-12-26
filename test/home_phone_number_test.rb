# frozen_string_literal: true

require 'test_helper'

class HomePhoneNumberTest < Minitest::Test
  def test_default
    h_default = HealthcarePhony::HomePhoneNumber.new
    assert_equal('++1', h_default.country_code)
    assert_match(/[0-9]{3}/, h_default.area_code)
    assert_match(/[0-9]{3}/, h_default.exchange_code)
    assert_match(/[0-9]{4}/, h_default.subscriber_number)
    assert_equal('PRN', h_default.use_code)
    assert_equal('PH', h_default.equipment_type)
  end

  def test_blank
    h_blank = HealthcarePhony::HomePhoneNumber.new(blank: 100)
    assert_equal('', h_blank.country_code)
    assert_equal('', h_blank.area_code)
    assert_equal('', h_blank.exchange_code)
    assert_equal('', h_blank.subscriber_number)
    assert_equal('', h_blank.use_code)
    assert_equal('', h_blank.equipment_type)
  end

  def test_specified_values
    h_spec = HealthcarePhony::HomePhoneNumber.new(use_code: 'XYZ', equipment_type: '123')
    assert_equal('XYZ', h_spec.use_code)
    assert_equal('123', h_spec.equipment_type)
  end
end
# frozen_string_literal: true

require 'test_helper'

class CellPhoneNumberTest < Minitest::Test
  def test_default
    c_default = HealthcarePhony::CellPhoneNumber.new
    assert_equal('++1', c_default.country_code)
    assert_match(/[0-9]{3}/, c_default.area_code)
    assert_match(/[0-9]{3}/, c_default.exchange_code)
    assert_match(/[0-9]{4}/, c_default.subscriber_number)
    assert_equal('ORN', c_default.use_code)
    assert_equal('CP', c_default.equipment_type)
  end

  def test_blank
    c_blank = HealthcarePhony::CellPhoneNumber.new(blank: 100)
    assert_equal('', c_blank.country_code)
    assert_equal('', c_blank.area_code)
    assert_equal('', c_blank.exchange_code)
    assert_equal('', c_blank.subscriber_number)
    assert_equal('', c_blank.use_code)
    assert_equal('', c_blank.equipment_type)
  end

  def test_specified_values
    c_spec = HealthcarePhony::CellPhoneNumber.new(use_code: 'XYZ', equipment_type: '123')
    assert_equal('XYZ', c_spec.use_code)
    assert_equal('123', c_spec.equipment_type)
  end
end

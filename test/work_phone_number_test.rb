# frozen_string_literal: true

require 'test_helper'

class WorkPhoneNumberTest < Minitest::Test
  def test_default
    w_default = HealthcarePhony::WorkPhoneNumber.new
    assert_equal('++1', w_default.country_code)
    assert_match(/[0-9]{3}/, w_default.area_code)
    assert_match(/[0-9]{3}/, w_default.exchange_code)
    assert_match(/[0-9]{4}/, w_default.subscriber_number)
    assert_equal('WPN', w_default.use_code)
    assert_equal('PH', w_default.equipment_type)
  end

  def test_blank
    w_blank = HealthcarePhony::WorkPhoneNumber.new(blank: 100)
    assert_equal('', w_blank.country_code)
    assert_equal('', w_blank.area_code)
    assert_equal('', w_blank.exchange_code)
    assert_equal('', w_blank.subscriber_number)
    assert_equal('', w_blank.use_code)
    assert_equal('', w_blank.equipment_type)
  end

  def test_specified_values
    w_spec = HealthcarePhony::WorkPhoneNumber.new(use_code: 'XYZ', equipment_type: '123')
    assert_equal('XYZ', w_spec.use_code)
    assert_equal('123', w_spec.equipment_type)
  end
end

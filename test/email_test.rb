# frozen_string_literal: true

require 'test_helper'
require 'uri/mailto'

class EmailTest < Minitest::Test
  def test_default
    e = HealthcarePhony::Email.new
    assert_match(URI::MailTo::EMAIL_REGEXP, e.email_address)
    assert_equal('NET', e.use_code)
    assert_equal('X.400', e.equipment_type)
  end

  def test_blank
    e = HealthcarePhony::Email.new(blank: 100)
    assert_equal('', e.email_address)
    assert_equal('', e.use_code)
    assert_equal('', e.equipment_type)
  end
end

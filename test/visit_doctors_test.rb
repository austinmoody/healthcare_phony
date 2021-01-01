# frozen_string_literal: true

require 'test_helper'

class VisitDoctorsTest < Minitest::Test
  def test_default
    vd = HealthcarePhony::VisitDoctors.new
    assert_kind_of(HealthcarePhony::Doctor, vd.attending)
    assert_kind_of(HealthcarePhony::Doctor, vd.referring)
    assert_kind_of(HealthcarePhony::Doctor, vd.consulting)
    assert_kind_of(HealthcarePhony::Doctor, vd.admitting)
  end
end

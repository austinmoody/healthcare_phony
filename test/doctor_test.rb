# frozen_string_literal: true

require 'test_helper'

class DoctorTest < Minitest::Test
  def test_default
    d = HealthcarePhony::Doctor.new
    assert_includes(%w[MD DO], d.name.degree)
    assert_match(/[0-9]{10}/, d.identifier.to_s)
    assert_kind_of(Integer, d.identifier)
  end

  def test_identifier
    identifier = 'This Is My Identifier'
    d = HealthcarePhony::Doctor.new(identifier: identifier)
    assert_equal(identifier, d.identifier)
  end
end

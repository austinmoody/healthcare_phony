# frozen_string_literal: true

require 'test_helper'

class GenderTest < Minitest::Test
  def setup
    @valid_descriptions = %w[Female Male Unknown]
    @valid_codes = %w[F M U]
  end

  def test_default
    g = HealthcarePhony::Gender.new
    assert_includes(@valid_codes, g.code)
    assert_includes(@valid_descriptions, g.description)
  end

  def test_blank
    g = HealthcarePhony::Gender.new(blank: 100)
    assert_equal('', g.code)
    assert_equal('', g.description)
  end
end

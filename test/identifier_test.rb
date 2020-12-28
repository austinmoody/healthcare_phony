# frozen_string_literal: true

require 'test_helper'

class IdentifierTest < Minitest::Test
  def test_default
    i = HealthcarePhony::Identifier.new
    assert_equal('', i.identifier_type_code)
    assert_match(/\d{10}/, i.identifier)
  end

  def test_type_code_specified
    type_code = 'MR'
    i = HealthcarePhony::Identifier.new(type_code: type_code)
    assert_equal(type_code, i.identifier_type_code)
  end

  def test_identifier_pattern
    i = HealthcarePhony::Identifier.new(pattern: 'PHONY\d{10}')
    assert_match(/PHONY\d{10}/, i.identifier)
  end
end

# frozen_string_literal: true

require 'test_helper'

class AddressTest < Minitest::Test
  def setup
    @a1 = HealthcarePhony::Address.new
  end

  def test_state_default
    assert_match(/[A-Z]{2}/, @a1.state)
  end

  def test_postal_code_default
    assert_match(/[0-9]{5}/, @a1.postal_code)
  end

  def test_address_line1_default
    assert(!@a1.address_line1.empty?)
  end

  def test_address_line2_default
    assert(!@a1.address_line2.empty?)
  end

  def test_city_default
    assert(!@a1.city.empty?)
  end

  def test_country_default
    assert(@a1.country.empty?)
  end

  def test_address_type_default
    file_join = ::File.join('../..', 'lib', 'healthcare_phony', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/address_type.yml"
    valid_types = Psych.load_file(data_file)
    assert_includes(valid_types, @a1.address_type)
  end

  def test_state_specified
    a = HealthcarePhony::Address.new(state: 'TN')
    assert_equal('TN', a.state)
  end

  def test_country_specified
    a = HealthcarePhony::Address.new(country: 'USA')
    assert_equal('USA', a.country)
  end

  def test_address_type_specified
    a = HealthcarePhony::Address.new(address_type: '1')
    assert_equal('1', a.address_type)
  end

  def test_address_type_file
    file_join = ::File.join('..', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/address_type.yml"
    valid_types = Psych.load_file(data_file)
    a = HealthcarePhony::Address.new(address_type_data_file: data_file)
    assert_includes(valid_types, a.address_type)
  end

  def test_address_blank
    a_blank = HealthcarePhony::Address.new(blank: 100)
    assert_same('', a_blank.address_line1)
    assert_same('', a_blank.address_line2)
    assert_same('', a_blank.city)
    assert_same('', a_blank.state)
    assert_same('', a_blank.postal_code)
    assert_same('', a_blank.country)
    assert_same('', a_blank.address_type)
  end
end

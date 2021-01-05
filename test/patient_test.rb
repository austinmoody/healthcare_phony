# frozen_string_literal: true

require 'test_helper'

class PatientTest < Minitest::Test
  def setup
    @p_default = HealthcarePhony::Patient.new
  end

  def test_default_birth
    # Multiple Birth Indicator & Birth Order
    assert_includes(%w[Y N], @p_default.multiple_birth_indicator)
    if @p_default.multiple_birth_indicator == 'Y'
      assert_includes(%w[1 2], @p_default.birth_order)
    else
      assert_equal('', @p_default.birth_order)
    end
  end

  def test_default_death
    ## Death Indicator & Death DateTime
    assert_includes(%w[Y N], @p_default.death_indicator)
    if @p_default.death_indicator == 'Y'
      assert(@p_default.death_datetime.to_date >= @p_default.date_of_birth.to_date &&
               @p_default.death_datetime.to_date <= Time.now.to_date)
    else
      assert_equal('', @p_default.death_datetime)
    end
  end

  def test_default_ssn
    # SSN
    assert_match(/[0-9]{3}-[0-9]{2}-[0-9]{4}/, @p_default.ssn)
  end

  def test_default_dob
    # DOB
    today = ::Date.today
    assert(@p_default.date_of_birth < today.prev_year(1) && @p_default.date_of_birth > today.prev_year(99))
  end

  def test_default_counts
    # Number of Names
    assert_equal(1, @p_default.names.length)

    # Number of Addresses
    assert_equal(1, @p_default.addresses.length)

    # Number of Races
    assert_equal(1, @p_default.races.length)
  end

  def test_multiple
    names_count = 5
    address_count = 5
    race_count = 5
    p = HealthcarePhony::Patient.new(names_count: names_count, address_count: address_count, race_count: race_count)

    assert_equal(names_count, p.names.length)
    assert_equal(address_count, p.addresses.length)
    assert_equal(race_count, p.races.length)
  end

  def test_dob_different
    min_age = 5
    max_age = 105
    p = HealthcarePhony::Patient.new(min_age: min_age, max_age: max_age)

    today = ::Date.today
    assert(p.date_of_birth < today.prev_year(min_age) && p.date_of_birth > today.prev_year(max_age))
  end

  def test_default_identifiers
    assert_equal('MR', @p_default.medical_record_number.identifier_type_code)
    assert_equal('AN', @p_default.account_number.identifier_type_code)
  end

  def test_names_count_zero
    p = HealthcarePhony::Patient.new(names_count: 0)
    assert_equal(1, p.names.length)
    p = HealthcarePhony::Patient.new(names_count: -2)
    assert_equal(1, p.names.length)
  end

  def test_address_count_zero
    p = HealthcarePhony::Patient.new(address_count: 0)
    assert_equal(1, p.addresses.length)
    p = HealthcarePhony::Patient.new(address_count: -2)
    assert_equal(1, p.addresses.length)
  end

  def test_race_count_zero
    p = HealthcarePhony::Patient.new(race_count: 0)
    assert_equal(1, p.races.length)
    p = HealthcarePhony::Patient.new(race_count: -2)
    assert_equal(1, p.races.length)
  end
end

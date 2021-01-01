# frozen_string_literal: true

require 'test_helper'

class HelperTest < Minitest::Test
  def test_get_array_string
    input = 'A,B,C,D'
    output = HealthcarePhony::Helper.get_array(input)
    assert_equal(input.split(','), output)
    assert_kind_of(Array, output)
  end

  def test_get_array_array
    input = %w[A B C D]
    output = HealthcarePhony::Helper.get_array(input)
    assert_equal(input, output)
    assert_kind_of(Array, output)
  end

  def test_npi_test_one
    number_one = 12_345_678
    number_two = 987_654_321
    number_three = 10_101_010_101
    assert_equal(22, HealthcarePhony::Helper.npi_step_one(number_one))
    assert_equal(23, HealthcarePhony::Helper.npi_step_one(number_two))
    assert_equal(12, HealthcarePhony::Helper.npi_step_one(number_three))
  end

  def test_npi_test_two
    number_one = 12_345_678
    number_two = 987_654_321
    number_three = 10_101_010_101
    assert_equal(66, HealthcarePhony::Helper.npi_step_two(number_one,
                                                          HealthcarePhony::Helper.npi_step_one(number_one)))
    assert_equal(67, HealthcarePhony::Helper.npi_step_two(number_two,
                                                          HealthcarePhony::Helper.npi_step_one(number_two)))
    assert_equal(36, HealthcarePhony::Helper.npi_step_two(number_three,
                                                          HealthcarePhony::Helper.npi_step_one(number_three)))
  end

  def test_next_zero
    assert_equal(0, HealthcarePhony::Helper.next_number_end_with_zero(0))
    assert_equal(10, HealthcarePhony::Helper.next_number_end_with_zero(1))
    assert_equal(20, HealthcarePhony::Helper.next_number_end_with_zero(12))
    assert_equal(50, HealthcarePhony::Helper.next_number_end_with_zero(45))
    assert_equal(100, HealthcarePhony::Helper.next_number_end_with_zero(99))
  end

  def test_get_check_digit
    number_one = 124_531_959 # check digit should be 9
    number_two = 116_458_286 # check digit should be 2
    number_three = 130_649_002 # check digit should be 4
    assert_equal(9, HealthcarePhony::Helper.get_npi_check_digit(number_one))
    assert_equal(2, HealthcarePhony::Helper.get_npi_check_digit(number_two))
    assert_equal(4, HealthcarePhony::Helper.get_npi_check_digit(number_three))
  end

  def test_double_alternate
    number_one = 12_345_678
    number_two = 987_654_321
    number_three = 10_101_010_101
    assert_equal(20, HealthcarePhony::Helper.double_alternate_digits(number_one))
    assert_equal(20, HealthcarePhony::Helper.double_alternate_digits(number_two))
    assert_equal(0, HealthcarePhony::Helper.double_alternate_digits(number_three))
  end
end

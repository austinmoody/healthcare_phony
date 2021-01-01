# frozen_string_literal: true

require 'test_helper'

class PersonNameTest < Minitest::Test
  def setup
    @default_degree = read_default_degrees
    @different_degree_file = different_degree_file
    @different_degree = read_different_degrees(@different_degree_file)
  end

  def read_default_degrees
    file_join = ::File.join('../..', 'lib', 'healthcare_phony', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/degree.yml"
    Psych.load_file(data_file)
  end

  def different_degree_file
    file_join = ::File.join('..', 'data_files')
    "#{::File.expand_path(file_join, __FILE__)}/degree.yml"
  end

  def read_different_degrees(data_file)
    Psych.load_file(data_file)
  end

  def test_default
    pn = HealthcarePhony::PersonName.new
    assert_match(/[A-Z][a-z]+/, pn.given_name)
    assert_match(/[A-Z][a-z]+/, pn.family_name)
    assert_match(/[A-Z][a-z]+/, pn.middle_name)
    assert_match(/[A-Za-z.]+/, pn.suffix)
    assert_match(/[A-Za-z.]+/, pn.prefix)
    assert_includes(@default_degree, pn.degree)
  end

  def test_blank
    pn = HealthcarePhony::PersonName.new(blank: 100)
    assert_equal('', pn.given_name)
    assert_equal('', pn.family_name)
    assert_equal('', pn.middle_name)
    assert_equal('', pn.suffix)
    assert_equal('', pn.prefix)
    assert_equal('', pn.degree)
  end

  def test_degree_file
    pn = HealthcarePhony::PersonName.new(degree_data_file: @different_degree_file)
    assert_includes(@different_degree, pn.degree)
  end

  def test_degree_string
    degrees = 'A,B,C'
    pn = HealthcarePhony::PersonName.new(degree: degrees)
    assert_includes(degrees.split(','), pn.degree)
  end

  def test_degree_array
    degrees = %w[A B C]
    pn = HealthcarePhony::PersonName.new(degree: degrees)
    assert_includes(degrees, pn.degree)
  end
end

# frozen_string_literal: true

require 'test_helper'

class RaceTest < Minitest::Test
  def setup
    setup_default
    setup_different
  end

  def setup_default
    # Read in default YAML file, create arrays to compare against
    file_join = ::File.join('../..', 'lib', 'healthcare_phony', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/race.yml"
    races = Psych.load_file(data_file)
    @valid_codes = races.map { |x| x[:code] }
    @valid_descriptions = races.map { |x| x[:description] }
  end

  def setup_different
    # Read in different data file to be able to set specifying different data file
    file_join = ::File.join('..', 'data_files')
    @different_data_file = "#{::File.expand_path(file_join, __FILE__)}/code_description_system.yml"
    races = Psych.load_file(@different_data_file)
    @different_codes = races.map { |x| x[:code] }
    @different_descriptions = races.map { |x| x[:description] }
  end

  def test_default
    r = HealthcarePhony::Race.new
    assert_equal('', r.coding_system)
    assert_includes(@valid_codes, r.code)
    assert_includes(@valid_descriptions, r.description)
  end

  def test_different
    r = HealthcarePhony::Race.new(race_data_file: @different_data_file)
    assert_equal('', r.coding_system)
    assert_includes(@different_codes, r.code)
    assert_includes(@different_descriptions, r.description)
  end
end

# frozen_string_literal: true

require 'test_helper'

class EthnicGroupTest < Minitest::Test
  def setup
    setup_default
    setup_different
  end

  def setup_default
    # Read in default YAML file, create arrays to compare against
    file_join = ::File.join('../..', 'lib', 'healthcare_phony', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/ethnic_group.yml"
    ethnic_groups = Psych.load_file(data_file)
    @valid_codes = ethnic_groups.map { |x| x[:code] }
    @valid_descriptions = ethnic_groups.map { |x| x[:description] }
    @valid_coding_systems = ethnic_groups.map { |x| x[:coding_system] }
  end

  def setup_different
    # Read in different data file to be able to set specifying different data file
    file_join = ::File.join('..', 'data_files')
    @different_data_file = "#{::File.expand_path(file_join, __FILE__)}/ethnic_group.yml"
    ethnic_groups = Psych.load_file(@different_data_file)
    @different_codes = ethnic_groups.map { |x| x[:code] }
    @different_descriptions = ethnic_groups.map { |x| x[:description] }
    @different_coding_systems = ethnic_groups.map { |x| x[:coding_system] }
  end

  def test_default
    eg = HealthcarePhony::EthnicGroup.new
    assert_includes(@valid_codes, eg.code)
    assert_includes(@valid_descriptions, eg.description)
    assert_includes(@valid_coding_systems, eg.coding_system)
  end

  def test_different_file
    eg = HealthcarePhony::EthnicGroup.new(ethnic_group_data_file: @different_data_file)
    assert_includes(@different_codes, eg.code)
    assert_includes(@different_descriptions, eg.description)
    assert_includes(@different_coding_systems, eg.coding_system)
  end

  def test_blank
    eg = HealthcarePhony::EthnicGroup.new(blank: 100)
    assert_equal('', eg.code)
    assert_equal('', eg.description)
    assert_equal('', eg.coding_system)
  end
end

# frozen_string_literal: true

require 'test_helper'

class VisitLocationTest < Minitest::Test
  def setup
    @vl = HealthcarePhony::VisitLocation.new
  end

  def test_poc_string
    poc = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(point_of_care: poc)
    assert_includes(poc.split(','), vl.point_of_care)
  end

  def test_poc_array
    poc = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(point_of_care: poc)
    assert_includes(poc, vl.point_of_care)
  end

  def test_room_string
    rooms = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(room: rooms)
    assert_includes(rooms, vl.room)
  end

  def test_room_array
    rooms = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(room: rooms)
    assert_includes(rooms, vl.room)
  end

  def test_bed_string
    beds = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(bed: beds)
    assert_includes(beds, vl.bed)
  end

  def test_bed_array
    beds = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(bed: beds)
    assert_includes(beds, vl.bed)
  end

  def test_facility_string
    facilities = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(facility: facilities)
    assert_includes(facilities.split(','), vl.facility)
  end

  def test_facility_array
    facilities = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(facility: facilities)
    assert_includes(facilities, vl.facility)
  end

  def test_location_status_string
    location_statuses = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(location_status: location_statuses)
    assert_includes(location_statuses.split(','), vl.status)
  end

  def test_location_status_array
    location_statuses = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(location_status: location_statuses)
    assert_includes(location_statuses, vl.status)
  end

  def test_location_type_string
    location_types = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(person_location_type: location_types)
    assert_includes(location_types.split(','), vl.type)
  end

  def test_location_type_array
    location_types = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(person_location_type: location_types)
    assert_includes(location_types, vl.type)
  end

  def test_building_string
    buildings = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(building: buildings)
    assert_includes(buildings.split(','), vl.building)
  end

  def test_building_array
    buildings = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(building: buildings)
    assert_includes(buildings, vl.building)
  end

  def test_floor_string
    floors = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(floor: floors)
    assert_includes(floors.split(','), vl.floor)
  end

  def test_floor_array
    floors = %w[ABC 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(floor: floors)
    assert_includes(floors, vl.floor)
  end

  def test_description_string
    descriptions = 'ABC,123,ZZZ'
    vl = HealthcarePhony::VisitLocation.new(location_description: descriptions)
    assert_includes(descriptions.split(','), vl.description)
  end

  def test_description_array
    descriptions = %w[AAA 123 ZZZ]
    vl = HealthcarePhony::VisitLocation.new(location_description: descriptions)
    assert_includes(descriptions, vl.description)
  end

  def test_poc_default
    assert_match(/[A-Z]{10}/, @vl.point_of_care)
  end

  def test_room_default
    assert_match(/[0-9]{3}/, @vl.room)
  end

  def test_bed_default
    assert_match(/[0-9a-zA-Z]{3}/, @vl.bed)
  end

  def test_facility_default
    assert_match(/[a-zA-Z.]+/, @vl.facility)
  end

  def test_status_default
    assert_match(/[A-Z]/, @vl.status)
  end

  def test_type_default
    valid_code = %w[C D H N O P S]
    assert_includes(valid_code, @vl.type)
  end

  def test_building_default
    assert_match(/[1-9]/, @vl.building)
  end

  def test_floor_default
    assert_match(/[0-9]{2}/, @vl.floor)
  end

  def test_description_default
    assert_match(/[a-zA-Z.]+/, @vl.description)
  end
end

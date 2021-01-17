# frozen_string_literal: true

require 'test_helper'

class Hl7MessageTest < Minitest::Test
  def test_adt_default
    m = HealthcarePhony::Hl7Message.new(message_types: 'ADT')

    assert_equal('ADT', m.message_type)
    assert_match(/A[0-9]{2}/, m.trigger_event)

    default_field_test(m)
  end

  def test_oru_default
    m = HealthcarePhony::Hl7Message.new(message_types: 'ORU')

    assert_equal('ORU', m.message_type)
    assert_match(/R[0-9]{2}/, m.trigger_event)

    default_field_test(m)
  end

  def test_mdm_default
    m = HealthcarePhony::Hl7Message.new(message_types: 'MDM')

    assert_equal('MDM', m.message_type)
    assert_match(/T[0-9]{2}/, m.trigger_event)

    default_field_test(m)
    default_datetime_test(m)
  end

  def default_field_test(message)
    assert_match(/PHONY[0-9]{10}/, message.message_control_id)
    assert_equal('2.5.1', message.version)
    assert_equal('', message.sending_facility)
    assert_equal('', message.sending_application)
    assert_equal('', message.receiving_application)
    assert_equal('', message.receiving_facility)
    assert_equal('P', message.processing_id)
  end

  def default_datetime_test(message)
    dt = Time.now
    assert((dt - message.message_datetime) < 700)
  end

  def test_field_spec_one
    types = %w[ABC 123]
    events = %w[XYZ 098]
    m = HealthcarePhony::Hl7Message.new(message_types: types, message_events: events, message_control_id_pattern: 'ALM\d{5}')

    assert_includes(types, m.message_type)
    assert_includes(events, m.trigger_event)
    assert_match(/ALM[0-9]{5}/, m.message_control_id)
  end

  def test_field_spec_two
    facilities = %w[FAC1 FAC2 111]
    m = HealthcarePhony::Hl7Message.new(message_sending_facility: facilities, message_receiving_facility: facilities)

    assert_includes(facilities, m.sending_facility)
    assert_includes(facilities, m.receiving_facility)
  end

  def test_field_spec_three
    applications = %w[APP1 222 APP3]
    m = HealthcarePhony::Hl7Message.new(message_sending_application: applications, message_receiving_application: applications)

    assert_includes(applications, m.sending_application)
    assert_includes(applications, m.receiving_application)
  end

  def test_field_spec_four
    version = '2.3'
    processing_id = 'X'
    m = HealthcarePhony::Hl7Message.new(message_version: version, message_processing_id: processing_id)

    assert_equal(version, m.version)
    assert_equal(processing_id, m.processing_id)
  end

  def test_message_type_file
    file_join = ::File.join('..', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/message_types.yml"
    valid_types = Psych.load_file(data_file)
    m = HealthcarePhony::Hl7Message.new(message_type_file: data_file)
    assert_includes(valid_types, m.message_type)
  end

  def test_adt_events_array
    events = %w[AAA BBB CCC]
    m = HealthcarePhony::Hl7Message.new(message_types: 'ADT', adt_events: events)
    assert_includes(events, m.trigger_event)
  end

  def test_adt_events_string
    events = 'AAA,BBB,CCC'
    m = HealthcarePhony::Hl7Message.new(message_types: 'ADT', adt_events: events)
    assert_includes(events.split(','), m.trigger_event)
  end

  def test_oru_events_array
    events = %w[AAA BBB CCC]
    m = HealthcarePhony::Hl7Message.new(message_types: 'ORU', oru_events: events)
    assert_includes(events, m.trigger_event)
  end

  def test_oru_events_string
    events = 'AAA,BBB,CCC'
    m = HealthcarePhony::Hl7Message.new(message_types: 'ORU', oru_events: events)
    assert_includes(events.split(','), m.trigger_event)
  end

  def test_mdm_events_array
    events = %w[AAA BBB CCC]
    m = HealthcarePhony::Hl7Message.new(message_types: 'MDM', mdm_events: events)
    assert_includes(events, m.trigger_event)
  end

  def test_mdm_events_string
    events = 'AAA,BBB,CCC'
    m = HealthcarePhony::Hl7Message.new(message_types: 'MDM', mdm_events: events)
    assert_includes(events.split(','), m.trigger_event)
  end
end

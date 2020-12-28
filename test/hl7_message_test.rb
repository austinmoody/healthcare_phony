# frozen_string_literal: true

require 'test_helper'

class Hl7MessageTest < Minitest::Test
  def test_adt_default
    m = HealthcarePhony::Hl7Message.new(types: 'ADT')

    assert_equal('ADT', m.message_type)
    assert_match(/A[0-9]{2}/, m.trigger_event)

    default_field_test(m)
  end

  def test_oru_default
    m = HealthcarePhony::Hl7Message.new(types: 'ORU')

    assert_equal('ORU', m.message_type)
    assert_match(/R[0-9]{2}/, m.trigger_event)

    default_field_test(m)
  end

  def test_mdm_default
    m = HealthcarePhony::Hl7Message.new(types: 'MDM')

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
    m = HealthcarePhony::Hl7Message.new(types: types, events: events, control_id_pattern: 'ALM\d{5}')

    assert_includes(types, m.message_type)
    assert_includes(events, m.trigger_event)
    assert_match(/ALM[0-9]{5}/, m.message_control_id)
  end

  def test_field_spec_two
    facilities = %w[FAC1 FAC2 111]
    m = HealthcarePhony::Hl7Message.new(sending_facility: facilities, receiving_facility: facilities)

    assert_includes(facilities, m.sending_facility)
    assert_includes(facilities, m.receiving_facility)
  end

  def test_field_spec_three
    applications = %w[APP1 222 APP3]
    m = HealthcarePhony::Hl7Message.new(sending_application: applications, receiving_application: applications)

    assert_includes(applications, m.sending_application)
    assert_includes(applications, m.receiving_application)
  end

  def test_field_spec_four
    version = '2.3'
    processing_id = 'X'
    m = HealthcarePhony::Hl7Message.new(version: version, processing_id: processing_id)

    assert_equal(version, m.version)
    assert_equal(processing_id, m.processing_id)
  end

  def test_adt_trigger_file
    file_join = ::File.join('..', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/trigger_events.yml"
    valid_triggers = Psych.load_file(data_file)
    m = HealthcarePhony::Hl7Message.new(types: 'ADT', adt_events_file: data_file)
    assert_includes(valid_triggers, m.trigger_event)
  end

  def test_oru_trigger_file
    file_join = ::File.join('..', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/trigger_events.yml"
    valid_triggers = Psych.load_file(data_file)
    m = HealthcarePhony::Hl7Message.new(types: 'ORU', oru_events_file: data_file)
    assert_includes(valid_triggers, m.trigger_event)
  end

  def test_mdm_trigger_file
    file_join = ::File.join('..', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/trigger_events.yml"
    valid_triggers = Psych.load_file(data_file)
    m = HealthcarePhony::Hl7Message.new(types: 'MDM', mdm_events_file: data_file)
    assert_includes(valid_triggers, m.trigger_event)
  end

  def test_message_type_file
    file_join = ::File.join('..', 'data_files')
    data_file = "#{::File.expand_path(file_join, __FILE__)}/message_types.yml"
    valid_types = Psych.load_file(data_file)
    m = HealthcarePhony::Hl7Message.new(message_type_file: data_file)
    assert_includes(valid_types, m.message_type)
  end
end

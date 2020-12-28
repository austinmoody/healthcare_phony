# frozen_string_literal: true

module HealthcarePhony
  # Public: Generates information needed to build an HL7v2 message
  class Hl7Message
    attr_accessor  :message_type,
                   :trigger_event,
                   :message_control_id,
                   :version,
                   :sending_application,
                   :sending_facility,
                   :receiving_application,
                   :receiving_facility,
                   :message_datetime,
                   :processing_id

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # version - HL7v2 version (MSH.12)
    # processing_id - Typically P or T (MSH.11)
    # types - Array of Message Types (MSH.9.1) to randomly choose from.  Specified as comma separated String or
    # Ruby array.
    # message_type_file - Location of file containing Message Types (MSH.9.1). If not specified then included
    # {hl7_message_types.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/hl7_message_types.yml] file will be used.
    # events - Array of Trigger Events (MSH.9.2) to randomly choose from.  Specified as command separated String or
    # Ruby array.
    # adt_events_file - Location of file containing ADT Trigger Events (MSH.9.2). If not specified then included
    # {adt_event_types.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/adt_event_types.yml] file will be used.
    # oru_events_file - Location of file containing ORU Trigger Events (MSH.9.2). If not specified then included
    # {oru_event_types.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/adt_event_types.yml] file will be used.
    # mdm_events_file - Location of file containing MDM Trigger Events (MSH.9.2). If not specified then included
    # {mdm_event_types.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/adt_event_types.yml] file will be used.
    # control_id_pattern - Regex pattern used to randomly generate MSH.10 values.  Default is PHONY\d{10} which will
    # generate a value like: PHONY6850295805
    # sending_facility - Array of Sending Facilities (MSH.4) to randomly choose from.  Specified as comma separated
    # String or Ruby Array.
    # sending_application - Array of Sending Applications (MSH.3) to randomly choose from.  Specified as comma
    # separated String or Ruby Array.
    # receiving_application - Array of Receiving Applications (MSH.5) to randomly choose from.  Specified as comma
    # separated String or Ruby Array.
    # receiving_facility - Array of Receiving Facilities (MSH.6) to randomly choose from.  Specified as comma separated
    # String or Ruby Array.
    def initialize(**init_args)
      define_message_type(init_args)
      define_trigger_event(init_args)
      define_control_id(init_args)
      @version = init_args[:version].nil? ? '2.5.1' : init_args[:version]
      define_sending_facility(init_args)
      define_sending_application(init_args)
      define_receiving_application(init_args)
      define_receiving_facility(init_args)

      # Potential use case to allow you to provide begin/end date?
      @message_datetime = Time.now

      @processing_id = init_args[:processing_id].nil? ? 'P' : init_args[:processing_id]
    end

    private

    def define_message_type(**init_args)
      file_name = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/hl7_message_types.yml"
      file_name = init_args[:message_type_file] unless init_args[:message_type_file].nil?
      hl7_message_types = if !init_args[:types].nil?
                            Helper.get_array(init_args[:types])
                          else
                            Psych.load_file(file_name)
                          end
      @message_type = hl7_message_types.nil? ? '' : hl7_message_types.sample
    end

    def define_trigger_event(**init_args)
      @trigger_event = Helper.get_array(init_args[:events]).sample
      @trigger_event = define_adt_trigger_event(init_args) unless @message_type != 'ADT'
      @trigger_event = define_oru_trigger_event(init_args) unless @message_type != 'ORU'
      @trigger_event = define_mdm_trigger_event(init_args) unless @message_type != 'MDM'
    end

    def define_adt_trigger_event(**init_args)
      event_types = get_adt_events(init_args)
      event_types&.sample
    end

    def define_oru_trigger_event(**init_args)
      event_types = get_oru_events(init_args)
      event_types&.sample
    end

    def define_mdm_trigger_event(**init_args)
      event_types = get_mdm_events(init_args)
      event_types&.sample
    end

    def get_adt_events(**init_args)
      file_name = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/adt_event_types.yml"
      file_name = init_args[:adt_events_file] unless init_args[:adt_events_file].nil?
      Psych.load_file(file_name)
    end

    def get_oru_events(**init_args)
      file_name = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/oru_event_types.yml"
      file_name = init_args[:oru_events_file] unless init_args[:oru_events_file].nil?
      Psych.load_file(file_name)
    end

    def get_mdm_events(**init_args)
      file_name = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/mdm_event_types.yml"
      file_name = init_args[:mdm_events_file] unless init_args[:mdm_events_file].nil?
      Psych.load_file(file_name)
    end

    def define_control_id(**init_args)
      control_id_pattern = init_args[:control_id_pattern].nil? ? 'PHONY\d{10}' : init_args[:control_id_pattern]
      @message_control_id = Regexp.new(control_id_pattern).random_example
    end

    def define_sending_facility(**init_args)
      sf_choices = Helper.get_array(init_args[:sending_facility])
      @sending_facility = !sf_choices.empty? ? sf_choices.sample : ''
    end

    def define_sending_application(**init_args)
      sa_choices = Helper.get_array(init_args[:sending_application])
      @sending_application = !sa_choices.empty? ? sa_choices.sample : ''
    end

    def define_receiving_application(**init_args)
      ra_choices = Helper.get_array(init_args[:receiving_application])
      @receiving_application = !ra_choices.empty? ? ra_choices.sample : ''
    end

    def define_receiving_facility(**init_args)
      rf_choices = Helper.get_array(init_args[:receiving_facility])
      @receiving_facility = !rf_choices.empty? ? rf_choices.sample : ''
    end
  end
end

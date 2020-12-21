# frozen_string_literal: true

module HealthcarePhony
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
      file_name = init_args[:msg_type_file] unless init_args[:msg_type_file].nil?
      hl7_message_types = if !init_args[:types].nil?
                            Helper.get_array(init_args[:types])
                          else
                            Helper.get_yaml_contents(file_name)
                          end
      @message_type = hl7_message_types.sample
    end

    def define_trigger_event(**init_args)
      event_types = Helper.get_array(init_args[:events])
      if @message_type == 'ADT' && event_types.empty?
        event_types = get_adt_events(init_args)
      elsif @message_type == 'ORU' && event_types.empty?
        event_types = get_oru_events(init_args)
      elsif @message_type == 'MDM' && event_types.empty?
        event_types = get_mdm_events(init_args)
      end
      @trigger_event = event_types.sample unless event_types.nil?
    end

    def get_adt_events(**init_args)
      file_name = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/adt_event_types.yml"
      file_name = init_args[:adt_events_file] unless init_args[:adt_events_file].nil?
      Helper.get_yaml_contents(file_name)
    end

    def get_oru_events(**init_args)
      file_name = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/oru_event_types.yml"
      file_name = init_args[:oru_events_file] unless init_args[:oru_events_file].nil?
      Helper.get_yaml_contents(file_name)
    end

    def get_mdm_events(**init_args)
      file_name = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/mdm_event_types.yml"
      file_name = init_args[:mdm_events_file] unless init_args[:mdm_events_file].nil?
      Helper.get_yaml_contents(file_name)
    end

    def define_control_id(**init_args)
      control_id_pattern = init_args[:control_id_pattern].nil? ? 'FAKER\d{10}' : init_args[:control_id_pattern]
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

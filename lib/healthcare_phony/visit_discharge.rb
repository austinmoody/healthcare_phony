# frozen_string_literal: true

module HealthcarePhony
  class VisitDischarge
    attr_accessor :disposition,
                  :location,
                  :datetime

    def initialize(**init_args)
      if init_args[:event_type] == 'A03'
        @disposition = define_discharge_disposition(init_args)
        @location = define_discharge_location(init_args)
        @datetime = define_discharge_datetime(init_args)
      else
        @disposition = ''
        @location = ''
        @datetime = nil
      end
    end

    private

    def define_discharge_disposition(**init_args)
      dd_choices = Helper.get_array(init_args[:discharge_disposition])
      if init_args[:event_type] != 'A03'
        ''
      elsif !dd_choices.empty?
        dd_choices.sample
      else
        data_file = "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/discharge_disposition.yml"
        file_based_choices = Helper.get_yaml_contents(data_file)
        file_based_choices.nil? ? '' : file_based_choices.sample
      end
    end

    def define_discharge_location(**init_args)
      dl_choices = Helper.get_array(init_args[:discharge_location])
      if !dl_choices.empty?
        dl_choices.sample
      else
        Faker::Company.name
      end
    end

    def define_discharge_datetime(**init_args)
      from_datetime = if init_args[:admit_datetime].nil?
                        Time.now
                      else
                        init_args[:admit_datetime]
                      end
      Faker::Time.between(from: from_datetime, to: DateTime.now)
    end
  end
end
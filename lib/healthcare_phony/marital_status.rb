# frozen_string_literal: true

module HealthcarePhony
  # Public: Generates a random MaritalStatus using data from a YAML file.
  class MaritalStatus
    attr_accessor :code,
                  :description,
                  :coding_system

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # marital_status_data_file - Location of YAML file containing Language data (Code, Description, and Coding System)
    # if a different set of random values is desired.  Otherwise the default file {marital_status.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/marital_status.yml] will be used.
    def initialize(**init_args)
      # TODO: allow a way for caller to pass in a custom set of codes to choose from
      # TODO: allow a way for caller to pass in % blank

      data_file = if !init_args[:marital_status_data_file].nil?
                    init_args[:marital_status_data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/marital_status.yml"
                  end
      ms_array = Psych.load_file(data_file)

      random_ms = ms_array.nil? ? '' : ms_array.sample

      @code = random_ms[:code]
      @description = random_ms[:description]
      @coding_system = random_ms[:coding_system]
    end
  end
end

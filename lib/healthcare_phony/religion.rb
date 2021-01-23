# frozen_string_literal: true

module HealthcarePhony
  # Public: Creates a Religion object for a Patient by randomly choosing a value from a YAML file.
  class Religion
    attr_accessor :code,
                  :description,
                  :coding_system

    # Public: Initializes an EthnicGroup. Pass in hash of different parameters, currently this includes:
    # religion_data_file - YAML file containing religion information to randomly choose from if different options than
    # those that come with gem are desired.  See {religion.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/religion.yml]
    # for default values.
    def initialize(init_args = {})
      # TODO: allow a way for caller to pass in a custom set of codes to choose from
      # TODO: allow a way for caller to pass in % blank

      data_file = if !init_args[:religion_data_file].nil?
                    init_args[:religion_data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/religion.yml"
                  end
      r_array = Psych.load_file(data_file)

      random_religion = r_array.nil? ? '' : r_array.sample

      @code = random_religion[:code]
      @description = random_religion[:description]
      @coding_system = random_religion[:coding_system]
    end
  end
end

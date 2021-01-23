# frozen_string_literal: true

module HealthcarePhony
  # Public: Creates a Race by randomly choosing values from a YAML file.
  class Race
    attr_accessor :code,
                  :description,
                  :coding_system

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # race_data_file - Location of YAML file containing a list of potential degrees to choose from. By default the
    # gem supplied file will be used.  The default file {race.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/race.yml].
    def initialize(init_args = {})
      # TODO: allow a way for caller to pass in % blank
      # TODO: set coding system

      data_file = if !init_args[:race_data_file].nil?
                    init_args[:race_data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/race.yml"
                  end
      race_array = Psych.load_file(data_file)

      random_race = race_array.nil? ? '' : race_array.sample

      @code = random_race[:code]
      @description = random_race[:description]
      @coding_system = ''
    end
  end
end

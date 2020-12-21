# frozen_string_literal: true

module HealthcarePhony
  class Race
    attr_accessor :code,
                  :description,
                  :coding_system

    def initialize(**init_args)
      # TODO: allow a way for caller to pass in % blank
      # TODO: set coding system

      data_file = if !init_args[:data_file].nil?
                    init_args[:data_file]
                  else
                    "#{::File.expand_path(::File.join('..', 'data_files'), __FILE__)}/race.yml"
                  end
      race_array = YAML.safe_load(File.read(data_file), [Symbol])

      random_race = race_array.nil? ? '' : race_array.sample

      @code = random_race[:code]
      @description = random_race[:description]
      @coding_system = ''
    end
  end
end

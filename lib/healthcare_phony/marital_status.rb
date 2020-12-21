# frozen_string_literal: true

module HealthcarePhony
  class MaritalStatus
    attr_accessor :code,
                  :description,
                  :coding_system

    def initialize(**init_args)
      # TODO: allow a way for caller to pass in a custom set of codes to choose from
      # TODO: allow a way for caller to pass in % blank

      data_file = if !init_args[:data_file].nil?
                    init_args[:data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/marital_status.yml"
                  end
      ms_array = YAML.safe_load(File.read(data_file), [Symbol])

      random_ms = ms_array.nil? ? '' : ms_array.sample

      @code = random_ms[:code]
      @description = random_ms[:description]
      @coding_system = random_ms[:coding_system]
    end
  end
end

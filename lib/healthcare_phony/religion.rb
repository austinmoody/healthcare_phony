# frozen_string_literal: true

module HealthcarePhony
  class Religion
    attr_accessor :code,
                  :description,
                  :coding_system

    def initialize(**init_args)
      # TODO: allow a way for caller to pass in a custom set of codes to choose from
      # TODO: allow a way for caller to pass in % blank

      data_file = if !init_args[:data_file].nil?
                    init_args[:data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/religion.yml"
                  end
      r_array = YAML.safe_load(File.read(data_file), [Symbol])

      random_religion = r_array.nil? ? '' : r_array.sample

      @code = random_religion[:code]
      @description = random_religion[:description]
      @coding_system = random_religion[:coding_system]
    end
  end
end

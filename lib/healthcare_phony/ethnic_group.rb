# frozen_string_literal: true

module HealthcarePhony
  class EthnicGroup
    attr_accessor :code,
                  :description,
                  :coding_system

    def initialize(**init_args)
      data_file = if !init_args[:data_file].nil?
                    init_args[:data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/ethnic_group.yml"
                  end
      e_array = YAML.safe_load(File.read(data_file), [Symbol])

      random_ethnic = e_array.nil? ? '' : e_array.sample

      @code = random_ethnic[:code]
      @description = random_ethnic[:description]
      @coding_system = random_ethnic[:coding_system]
    end
  end
end

# frozen_string_literal: true

module HealthcarePhony
  class Language
    attr_accessor :code,
                  :description,
                  :coding_system

    def initialize(**init_args)
      # TODO: allow a way for caller to pass in a custom set of codes to choose from.
      # TODO: allow a way for caller to pass in % blank

      data_file = if !init_args[:data_file].nil?
                    init_args[:data_file]
                  else
                    ::File.expand_path(::File.join('..', 'data_files'), __FILE__) + '/language.yml'
                  end
      language_array = YAML.safe_load(File.read(data_file), [Symbol])
      random_language = language_array.nil? ? '' : language_array.sample

      @code = random_language[:code]
      @description = random_language[:description]
      @coding_system = random_language[:coding_system]

    end
  end
end

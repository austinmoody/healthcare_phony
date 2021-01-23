# frozen_string_literal: true

module HealthcarePhony
  # Public: Generate random Language using data from YAML file.
  class Language
    attr_accessor :code,
                  :description,
                  :coding_system

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # language_data_file - Location of YAML file containing Language data (Code, Description, and Coding System) if a
    # different set of random values is desired.  Otherwise the default file {language.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/language.yml] will be used.
    def initialize(init_args = {})
      # TODO: allow a way for caller to pass in a custom set of codes to choose from.
      # TODO: allow a way for caller to pass in % blank

      data_file = if !init_args[:language_data_file].nil?
                    init_args[:language_data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/language.yml"
                  end
      language_array = Psych.load_file(data_file)
      random_language = language_array.nil? ? '' : language_array.sample

      @code = random_language[:code]
      @description = random_language[:description]
      @coding_system = random_language[:coding_system]
    end
  end
end

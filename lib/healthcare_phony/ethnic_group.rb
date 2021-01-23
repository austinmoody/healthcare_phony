# frozen_string_literal: true

module HealthcarePhony
  # Public: Randomly generates an ethnic group
  class EthnicGroup
    attr_accessor :code,
                  :description,
                  :coding_system

    # Public: Initializes an EthnicGroup. Pass in hash of different parameters, currently this includes:
    # blank - An integer representing the % of times EthnicGroup components should be blank.
    # ethnic_group_data_file - YAML file containing ethnic group information to randomly choose from if different options than
    # those that come with gem are desired.  See {ethnic_group.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/ethnic_group.yml]
    # for default values.
    def initialize(init_args = {})
      @set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      data_file = if !init_args[:ethnic_group_data_file].nil?
                    init_args[:ethnic_group_data_file]
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/ethnic_group.yml"
                  end
      e_array = Psych.load_file(data_file)
      random_ethnic = e_array.nil? ? '' : e_array.sample
      @code = @set_blank == true ? '' : random_ethnic[:code]
      @description = @set_blank == true ? '' : random_ethnic[:description]
      @coding_system = @set_blank == true ? '' : random_ethnic[:coding_system]
    end

    private

    # Private: Boolean set during initialization if Address components should be set to blank.
    attr_accessor :set_blank
  end
end

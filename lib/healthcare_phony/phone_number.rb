# frozen_string_literal: true

module HealthcarePhony
  # Public: Generates a fake phone number
  class PhoneNumber
    attr_accessor :number,
                  :country_code,
                  :area_code,
                  :exchange_code,
                  :subscriber_number,
                  :use_code,
                  :equipment_type

    def initialize(init_args = {})
      # Public: Initializes a home phone number. Pass in hash of different parameters, currently this includes:
      # blank - An integer representing the % of times phone number components should be blank.
      # use_code_data_file - YAML file containing use codes to randomly choose from.  If not specified then values from
      # {tele_use_code.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/tele_use_code.yml] are used.
      # equipment_type_data_file - YAML file containing equipment type codes to randomly choose from.  If not specified
      # then values {tele_equipment_type}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/tele_equipment_type.yml] will be used.
      @set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      @use_code_data_file = init_args[:use_code_data_file]
      @equipment_type_data_file = init_args[:equipment_type_data_file]
      define_country_code
      define_area_code
      define_exchange_code
      define_subscriber_number
      define_use_code
      define_equipment_type
    end

    private

    # Private: Boolean set during initialization if Address components should be set to blank.
    attr_accessor :set_blank

    # Private: Location of data file of use codes
    attr_accessor :use_code_data_file

    # Private: Location of data file of equipment types
    attr_accessor :equipment_type_data_file

    def define_country_code
      @country_code = Faker::PhoneNumber.country_code
      @country_code = '' unless @set_blank == false
    end

    def define_area_code
      @area_code = Faker::PhoneNumber.area_code
      @area_code = '' unless @set_blank == false
    end

    def define_exchange_code
      @exchange_code = Faker::PhoneNumber.exchange_code
      @exchange_code = '' unless @set_blank == false
    end

    def define_subscriber_number
      @subscriber_number = Faker::PhoneNumber.subscriber_number
      @subscriber_number = '' unless @set_blank == false
    end

    def define_use_code
      data_file = if !@use_code_data_file.nil?
                    @use_code_data_file
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/tele_use_code.yml"
                  end
      use_codes = Psych.load_file(data_file)
      @use_code = use_codes.nil? ? '' : use_codes.sample
      @use_code = '' unless @set_blank == false
    end

    def define_equipment_type
      data_file = if !@equipment_type_data_file.nil?
                    @equipment_type_data_file
                  else
                    "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/tele_equipment_type.yml"
                  end
      equipment_types = Psych.load_file(data_file)
      @equipment_type = equipment_types.nil? ? '' : equipment_types.sample
      @equipment_type = '' unless @set_blank == false
    end
  end
end

# frozen_string_literal: true

module HealthcarePhony
  # Public: Generates a fake Address
  class Address
    attr_accessor :address_line1, :address_line2, :city, :state, :postal_code, :country, :address_type

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # blank - An integer representing the % of times Address components should be blank.
    # state - Allows specification of the Address state instead of randomly being chosen.
    # country - Allows specification of the Address country.  Is blank by default.
    # address_type - Allows specification of the Address type.
    # address_type_data_file - YAML file containing address types to randomly choose from if different options than
    # those that come with gem are desired.
    # See {address_type.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/address_type.yml]
    def initialize(**init_args)
      @set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      @state = init_args[:state]
      @country = init_args[:country]
      @address_type_data_file = init_args[:address_type_data_file]
      @address_type = init_args[:address_type]
      define_address_line1
      define_address_line2
      define_city
      define_state
      define_postal_code
      define_country
      define_address_type
    end

    private

    # Private: Boolean set during initialization if Address components should be set to blank.
    attr_accessor :set_blank
    # Private: File containing address types to randomly choose from.
    attr_accessor :address_type_data_file

    # Private: Randomly generates the street address (address_line1)
    def define_address_line1
      @address_line1 = Faker::Address.street_address
      @address_line1 = '' unless @set_blank == false
    end

    # Private: Randomly generates a second part of the street address (address_line2)
    def define_address_line2
      @address_line2 = Faker::Address.secondary_address
      @address_line2 = '' unless @set_blank == false
    end

    # Private: Randomly generates the city.
    def define_city
      @city = Faker::Address.city
      @city = '' unless @set_blank == false
    end

    # Private: Randomly generates the state unless state was specified during initialization.
    def define_state
      @state = Faker::Address.state_abbr if @state.nil?
      @state = '' unless @set_blank == false
    end

    # Private: Randomly generates the postal/zip code.
    def define_postal_code
      @postal_code = Faker::Address.zip_code(state_abbreviation: @state)
      @postal_code = '' unless @set_blank == false
    end

    def define_country
      @country = '' if @country.nil?
      @country = '' unless @set_blank == false
    end

    # Private: Sets the address type, either by the address type specified during initialization, by randomly choosing
    # a value from the address_type.yml file, or by a random value from a file specified by address_type_data_file
    # during initialization.
    def define_address_type
      if @address_type.nil?
        data_file = if !@address_type_data_file.nil?
                      @address_type_data_file
                    else
                      "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/address_type.yml"
                    end
        address_types = Psych.load_file(data_file)
        @address_type = address_types.sample unless address_types.nil?
      end
      @address_type = '' unless @set_blank == false
    end
  end
end

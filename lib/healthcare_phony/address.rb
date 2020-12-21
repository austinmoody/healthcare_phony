# frozen_string_literal: true

module HealthcarePhony
  class Address
    attr_accessor :address_line1,
                  :address_line2,
                  :city,
                  :state,
                  :postal_code,
                  :country,
                  :address_type

    def initialize(**init_args)
      set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      init_args[:set_blank] = set_blank
      define_address_line1(init_args)
      define_address_line2(init_args)
      define_city(init_args)
      define_state(init_args)
      define_postal_code(init_args)
      define_country(init_args)
      define_address_type(init_args)
    end

    private

    def define_address_line1(**init_args)
      @address_line1 = Faker::Address.street_address
      @address_line1 = '' unless init_args[:set_blank] == false
    end

    def define_address_line2(**init_args)
      @address_line2 = Faker::Address.secondary_address
      @address_line2 = '' unless init_args[:set_blank] == false
    end

    def define_city(**init_args)
      @city = Faker::Address.city
      @city = '' unless init_args[:set_blank] == false
    end

    def define_state(**init_args)
      @state = if init_args[:state].nil?
                 Faker::Address.state_abbr
               else
                 init_args[:state]
               end
      @state = '' unless init_args[:set_blank] == false
    end

    def define_postal_code(**init_args)
      @postal_code = Faker::Address.zip_code(state_abbreviation: @state)
      @postal_code = '' unless init_args[:set_blank] == false
    end

    def define_country(**init_args)
      @country = if !init_args[:country].nil?
                   init_args[:country]
                 else
                   ''
                 end
      @country = '' unless init_args[:set_blank] == false
    end

    def define_address_type(**init_args)
      data_file = if !init_args[:address_type_data_file].nil?
                    init_args[:address_type_data_file]
                  else
                    ::File.expand_path(::File.join('..', 'data_files'), __FILE__) + '/address_type.yml'
                  end
      address_types = YAML.safe_load(File.read(data_file), [Symbol])
      @address_type = address_types.sample unless address_types.nil?
      @address_type = init_args[:address_type] unless init_args[:address_type].nil?
      @address_type = '' unless init_args[:set_blank] == false
    end
  end
end

# frozen_string_literal: true

module HealthcarePhony
  class PhoneNumber
    attr_accessor :number,
                  :country_code,
                  :area_code,
                  :exchange_code,
                  :subscriber_number,
                  :use_code,
                  :equipment_type

    def initialize(**init_args)
      set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      init_args[:set_blank] = set_blank
      define_country_code(init_args)
      define_area_code(init_args)
      define_exchange_code(init_args)
      define_subscriber_number(init_args)
      define_use_code(init_args)
      define_equipment_type(init_args)
    end

    def local_number
      @exchange_code + @subscriber_number
    end

    private

    def define_country_code(**init_args)
      @country_code = Faker::PhoneNumber.country_code
      @country_code = '' unless init_args[:set_blank] == false
    end

    def define_area_code(**init_args)
      @area_code = Faker::PhoneNumber.area_code
      @area_code = '' unless init_args[:set_blank] == false
    end

    def define_exchange_code(**init_args)
      @exchange_code = Faker::PhoneNumber.exchange_code
      @exchange_code = '' unless init_args[:set_blank] == false
    end

    def define_subscriber_number(**init_args)
      @subscriber_number = Faker::PhoneNumber.subscriber_number
      @subscriber_number = '' unless init_args[:set_blank] == false
    end

    def define_use_code(**init_args)
      data_file = if !init_args[:use_code_data_file].nil?
                    init_args[:use_code_data_file]
                  else
                    ::File.expand_path(::File.join('..', 'data_files'), __FILE__) + '/tele_use_code.yml'
                  end
      use_codes = YAML.safe_load(File.read(data_file), [Symbol])
      @use_code = use_codes.nil? ? '' : use_codes.sample
      @use_code = '' unless init_args[:set_blank] == false
    end

    def define_equipment_type(**init_args)
      data_file = if !init_args[:equipment_type_data_file].nil?
                    init_args[:equipment_type_data_file]
                  else
                    ::File.expand_path(::File.join('..', 'data_files'), __FILE__) + '/tele_equipment_type.yml'
                  end
      equipment_types = YAML.safe_load(File.read(data_file), [Symbol])
      @equipment_type = equipment_types.nil? ? '' : equipment_types.sample
      @equipment_type = '' unless init_args[:set_blank] == false
    end
  end
end

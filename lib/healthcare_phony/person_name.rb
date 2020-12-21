# frozen_string_literal: true

ROOT = File.dirname(File.expand_path(__FILE__))

module HealthcarePhony
  class PersonName
    attr_accessor :family_name,
                  :given_name,
                  :middle_name,
                  :suffix,
                  :prefix,
                  :degree

    def initialize(**init_args)
      set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      init_args[:set_blank] = set_blank

      @given_name = define_given_name(init_args)
      @family_name = define_family_name(init_args)
      @middle_name = define_middle_name(init_args)
      @suffix = define_suffix(init_args)
      @prefix = define_prefix(init_args)
      @degree = define_degree(init_args)
    end

    private

    def define_given_name(**init_args)
      if init_args[:set_blank]
        ''
      elsif !init_args[:gender].nil? && init_args[:gender].code == 'M'
        Faker::Name.male_first_name
      elsif !init_args[:gender].nil? && init_args[:gender].code == 'F'
        Faker::Name.female_first_name
      else
        Faker::Name.first_name
      end
    end

    def define_family_name(**init_args)
      if init_args[:set_blank]
        ''
      else
        Faker::Name.last_name
      end
    end

    def define_middle_name(**init_args)
      if init_args[:set_blank]
        ''
      else
        Faker::Name.middle_name
      end
    end

    def define_suffix(**init_args)
      if init_args[:set_blank]
        ''
      else
        Faker::Name.suffix
      end
    end

    def define_prefix(**init_args)
      if init_args[:set_blank]
        ''
      else
        Faker::Name.prefix
      end
    end

    def define_degree(**init_args)
      if init_args[:set_blank]
        ''
      else
        get_degree_from_file(init_args)
      end
    end

    def get_degree_from_file(**init_args)
      data_file = if !init_args[:degree_data_file].nil?
                    init_args[:degree_data_file]
                  else
                    ::File.expand_path(::File.join('..', 'data_files'), __FILE__) + '/degree.yml'
                  end
      degrees = YAML.safe_load(File.read(data_file), [Symbol])
      degrees.nil? ? '' : degrees.sample
    end
  end
end

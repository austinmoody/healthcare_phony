# frozen_string_literal: true

module HealthcarePhony
  # Public: Randomly generates a patient name.
  class PersonName
    attr_accessor :family_name,
                  :given_name,
                  :middle_name,
                  :suffix,
                  :prefix,
                  :degree

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # blank - An integer representing the % of times PatientName components should be blank.
    # gender - A Gender object which will be used to generate a Male or Female name if specified.
    # degree_data_file - Location of YAML file containing a list of potential degrees to choose from. By default the
    # gem supplied file will be used.  The default file {degree.yml}[https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/degree.yml].
    def initialize(**init_args)
      @set_blank = !init_args[:blank].nil? && Helper.random_with_blank('X', init_args[:blank]) == ''
      @gender = init_args[:gender]
      @degree_data_file = get_degree_data_file(init_args)
      @given_name = define_given_name
      @family_name = define_family_name
      @middle_name = define_middle_name
      @suffix = define_suffix
      @prefix = define_prefix
      @degree = define_degree(init_args)
    end

    private

    # Private: Boolean set during initialization if Address components should be set to blank.
    attr_accessor :set_blank
    attr_accessor :degree_data_file

    def get_degree_data_file(**init_args)
      if !init_args[:degree_data_file].nil?
        init_args[:degree_data_file]
      else
        "#{::File.expand_path(::File.join("..", "data_files"), __FILE__)}/degree.yml"
      end
    end

    def define_given_name
      if @set_blank
        ''
      elsif !@gender.nil? && @gender.code == 'M'
        Faker::Name.male_first_name
      elsif !@gender.nil? && @gender.code == 'F'
        Faker::Name.female_first_name
      else
        Faker::Name.first_name
      end
    end

    def define_family_name
      if @set_blank
        ''
      else
        Faker::Name.last_name
      end
    end

    def define_middle_name
      if @set_blank
        ''
      else
        Faker::Name.middle_name
      end
    end

    def define_suffix
      if @set_blank
        ''
      else
        Faker::Name.suffix
      end
    end

    def define_prefix
      if @set_blank
        ''
      else
        Faker::Name.prefix
      end
    end

    def define_degree(**init_args)
      if @set_blank
        ''
      elsif !init_args[:degree].nil?
        degree_choices = Helper.get_array(init_args[:degree])
        degree_choices.sample unless degree_choices.empty?
      else
        degrees_from_file
      end
    end

    def degrees_from_file
      degrees = Psych.load_file(@degree_data_file)
      degrees.nil? ? '' : degrees.sample
    end
  end
end

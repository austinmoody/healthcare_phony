# frozen_string_literal: true

module HealthcarePhony
  # Public: Generates various location information associated with a visit.
  class VisitLocation
    attr_accessor :point_of_care,
                  :room,
                  :bed,
                  :facility,
                  :status,
                  :type,
                  :building,
                  :floor,
                  :description

    # Public: Initializes an Address. Pass in hash of different parameters, currently this includes:
    # point_of_care - Array of potential points of care (PV1.3.1) to randomly choose from. Specified as comma separated
    # String or Ruby array. Otherwise random example generated.
    # room - Array of potential rooms (PV1.3.2) to randomly choose from. Specified as comma separated String or Ruby
    # array.  Otherwise a random 3 digit number is generated.
    # bed - Array of potential beds (PV1.3.3) to randomly choose from. Specified as comma separated String or Ruby
    # array. Otherwise a 3 character sequence is created.
    # facility - Array of potential facility names (PV1.3.4) to randomly choose from. Specified as comma separated
    # String or Ruby array. Otherwise a random string is generated.
    # location_status - Array of potential location statuses (PV1.3.5) to randomly choose from. Specified as comma
    # separated String or Ruby array. Otherwise a random uppercase letter is generated to use.
    # person_location_type - Array of potential person location types (PV1.3.6) to randomly choose from.  Specified as
    # comma separated String or Ruby array. Otherwise values from HL7 v2.5.1 Table 0305 will be used.
    # building - Array of potential building information (PV1.3.7) to randomly choose from. Specified as a comma
    # separated String or Ruby array. Otherwise a random digit 1-9 is used.
    # floor - Array of potential floor information (PV1.3.8) to randomly choose from.  Specified as a comma separated
    # String or Ruby array. Otherwise a random 2 digit number is used.
    # location_description - Array of potential location descriptions (PV1.3.9) to randomly choose from.  Specified as
    # a comma separated String or Ruby array. Otherwise a random string is generated.
    def initialize(init_args = {})
      @point_of_care = define_point_of_care(init_args)
      @room = define_room(init_args)
      @bed = define_bed(init_args)
      @facility = define_facility(init_args)
      @status = define_status(init_args)
      @type = define_type(init_args)
      @building = define_building(init_args)
      @floor = define_floor(init_args)
      @description = define_description(init_args)
    end

    private

    def define_point_of_care(init_args = {})
      poc_choices = Helper.get_array(init_args[:point_of_care])
      !poc_choices.empty? ? poc_choices.sample : /[A-Z]{10}/.random_example
    end

    def define_room(init_args = {})
      room_choices = Helper.get_array(init_args[:room])
      if !room_choices.empty?
        room_choices.sample
      else
        Faker::Alphanumeric.alphanumeric(number: 3, min_alpha: 0, min_numeric: 3)
      end
    end

    def define_bed(init_args = {})
      bed_choices = Helper.get_array(init_args[:bed])
      if !bed_choices.empty?
        bed_choices.sample
      else
        Faker::Alphanumeric.alphanumeric(number: 3, min_alpha: 1, min_numeric: 2)
      end
    end

    def define_facility(init_args = {})
      fac_choices = Helper.get_array(init_args[:facility])
      !fac_choices.empty? ? fac_choices.sample : Faker::Lorem.sentence
    end

    def define_status(init_args = {})
      ls_choices = Helper.get_array(init_args[:location_status])
      !ls_choices.empty? ? ls_choices.sample : /[A-Z]/.random_example
    end

    def define_type(init_args = {})
      plt_choices = Helper.get_array(init_args[:person_location_type])
      !plt_choices.empty? ? plt_choices.sample : %w[C D H N O P S].sample
    end

    def define_building(init_args = {})
      building_choices = Helper.get_array(init_args[:building])
      !building_choices.empty? ? building_choices.sample : /[1-9]/.random_example
    end

    def define_floor(init_args = {})
      floor_choices = Helper.get_array(init_args[:floor])
      !floor_choices.empty? ? floor_choices.sample : /[0-9]{2}/.random_example
    end

    def define_description(init_args = {})
      ld_choices = Helper.get_array(init_args[:location_description])
      if !ld_choices.empty?
        ld_choices.sample
      else
        Faker::Lorem.sentence
      end
    end
  end
end

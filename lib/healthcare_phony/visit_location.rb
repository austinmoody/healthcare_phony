# frozen_string_literal: true

module HealthcarePhony
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

    def initialize(**init_args)
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

    def define_point_of_care(**init_args)
      poc_choices = Helper.get_array(init_args[:point_of_care])
      !poc_choices.empty? ? poc_choices.sample : /[A-Z]{10}/.random_example
    end

    def define_room(**init_args)
      room_choices = Helper.get_array(init_args[:room])
      if !room_choices.empty?
        room_choices.sample
      else
        Faker::Alphanumeric.alphanumeric(number: 3, min_alpha: 0, min_numeric: 3)
      end
    end

    def define_bed(**init_args)
      bed_choices = Helper.get_array(init_args[:bed])
      if !bed_choices.empty?
        bed_choices.sample
      else
        Faker::Alphanumeric.alphanumeric(number: 3, min_alpha: 1, min_numeric: 2)
      end
    end

    def define_facility(**init_args)
      fac_choices = Helper.get_array(init_args[:facility])
      !fac_choices.empty? ? fac_choices.sample : Faker::Company.name
    end

    def define_status(**init_args)
      ls_choices = Helper.get_array(init_args[:location_status])
      !ls_choices.empty? ? ls_choices.sample : /[A-Z]/.random_example
    end

    def define_type(**init_args)
      plt_choices = Helper.get_array(init_args[:person_location_type])
      !plt_choices.empty? ? plt_choices.sample : %w[C D H N O P S].sample
    end

    def define_building(**init_args)
      building_choices = Helper.get_array(init_args[:building])
      !building_choices.empty? ? building_choices.sample : /[1-9]/.random_example
    end

    def define_floor(**init_args)
      floor_choices = Helper.get_array(init_args[:floor])
      !floor_choices.empty? ? floor_choices.sample : /[0-9]{2}/.random_example
    end

    def define_description(**init_args)
      ld_choices = Helper.get_array(init_args[:location_description])
      if !ld_choices.empty?
        ld_choices.sample
      else
        Faker::Company.name
      end
    end
  end
end

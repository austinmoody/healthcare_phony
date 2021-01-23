# frozen_string_literal: true

module HealthcarePhony
  # Public: Randomly generates a Gender.
  class Gender
    attr_accessor :code,
                  :description

    # Public: Initializes a Gender. Pass in hash of different parameters, currently this includes:
    # blank - An integer representing the % of times Address components should be blank.
    def initialize(init_args = {})
      @description = %w[Female Male Unknown].sample

      @description = if !init_args[:blank].nil?
                       Helper.random_with_blank(@description, init_args[:blank])
                     else
                       @description
                     end
      @code = @description == '' ? '' : @description[0]
    end
  end
end

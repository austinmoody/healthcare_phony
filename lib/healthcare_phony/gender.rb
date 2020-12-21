# frozen_string_literal: true

module HealthcarePhony
  class Gender
    attr_accessor :code,
                  :description

    def initialize(**init_args)
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

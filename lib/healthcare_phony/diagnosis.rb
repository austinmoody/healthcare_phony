# frozen_string_literal: true

module HealthcarePhony
  class Diagnosis
    attr_accessor :coding_method,
                  :code,
                  :description,
                  :coding_system,
                  :date_time,
                  :type
  end
end

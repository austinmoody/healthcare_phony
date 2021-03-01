# frozen_string_literal: true

module HealthcarePhony
  # Public: Creates providers associated with visit.  Attending (PV1.7), Referring (PV1.8), Consulting (PV1.9), and
  # Admitting (PV1.17)
  class VisitDoctors
    attr_accessor :attending,
                  :referring,
                  :consulting,
                  :admitting

    def initialize(init_args = {})
      @attending = Doctor.new(init_args)
      @referring = Doctor.new(init_args)
      @consulting = Doctor.new(init_args)
      @admitting = Doctor.new(init_args)
    end
  end
end

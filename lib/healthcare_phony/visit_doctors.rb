# frozen_string_literal: true

module HealthcarePhony
  class VisitDoctors
    attr_accessor :attending,
                  :referring,
                  :consulting,
                  :admitting

    def initialize
      @attending = Doctor.new
      @referring = Doctor.new
      @consulting = Doctor.new
      @admitting = Doctor.new
    end
  end
end

# frozen_string_literal: true

require 'faker'
require 'erb'

Dir[File.join(__dir__, 'healthcare_phony', '*.rb')].sort.each { |file| require file }

Faker::Config.locale = 'en-US'

module HealthcarePhony
  class Adt
    attr_reader :template_file

    def initialize(template_file = nil)
      @template_file = if template_file.nil?
                         File.join(File.dirname(__FILE__), 'healthcare_phony', 'templates', 'adt_example.erb')
                       else
                         template_file
                       end
    end

    def to_s
      template = ERB.new(File.read(@template_file))
      message = Hl7Message.new
      patient = Patient.new
      visit = PatientVisit.new
      template.result_with_hash({ patient: patient, hl7: message, visit: visit })
    end
  end
end

class String
  def to_hl7date
    self
  end

  def to_hl7datetime
    self
  end
end

class Date
  def to_hl7date
    strftime('%Y%m%d')
  end
end

class Time
  def to_hl7datetime
    strftime('%Y%m%d%H%M%S')
  end
end

class NilClass
  def to_hl7datetime
    ''
  end

  def to_hl7date
    ''
  end
end

# frozen_string_literal: true

require 'erb'
require 'faker'
require 'psych'
require 'regexp-examples'

Dir[File.join(__dir__, 'healthcare_phony', '*.rb')].sort.each { |file| require file }

Faker::Config.locale = 'en-US'

module HealthcarePhony
  class Adt
    attr_reader :template, :adt_arguments, :hl7_message, :patient, :visit

    def initialize(init_args = {})
      @adt_arguments = init_args
      @adt_arguments[:message_types] = 'ADT'
      set_template
      @hl7_message = Hl7Message.new(@adt_arguments)
      @patient = Patient.new(@adt_arguments)
      @visit = PatientVisit.new(@adt_arguments.merge({ visit_type: set_visit_type }))
    end

    def to_s
      erb_template = ERB.new(@template)
      erb_template.result_with_hash({ patient: @patient, hl7: @hl7_message, visit: @visit })
    end

    private

    def set_template
      unless @adt_arguments[:template].nil?
        @template = @adt_arguments[:template]
        return
      end
      @template = if @adt_arguments[:template_file].nil?
                    File.read(File.join(File.dirname(__FILE__), 'healthcare_phony', 'templates', 'adt_example.erb'))
                  else
                    File.read(@adt_arguments[:template_file])
                  end
    end

    def set_visit_type
      case @hl7_message.trigger_event
      when 'A01'
        HealthcarePhony::VisitType::ADMIT
      when 'A03'
        HealthcarePhony::VisitType::DISCHARGE
      when 'A04'
        HealthcarePhony::VisitType::REGISTRATION
      else
        HealthcarePhony::VisitType::OTHER
      end
    end
  end

  class CsvFile
    attr_reader :template_file, :number_of_rows

    def initialize(number_of_rows, template_file = nil)
      @template_file = if template_file.nil?
                         File.join(File.dirname(__FILE__), 'healthcare_phony', 'templates', 'csv_example.erb')
                       else
                         template_file
                       end
      @number_of_rows = number_of_rows
    end

    def to_s
      template = ERB.new(File.read(@template_file), trim_mode: '<>')
      counter = 0
      output_string = ''
      while counter < @number_of_rows
        output_string += "#{template.result_with_hash({ patient: Patient.new, write_header: counter.zero? })}\n"
        counter += 1
      end
      output_string
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

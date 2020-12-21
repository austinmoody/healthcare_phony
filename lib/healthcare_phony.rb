# frozen_string_literal: true

require 'faker'

Dir[File.join(__dir__, 'healthcare_phony', '*.rb')].sort.each { |file| require file }

Faker::Config.locale = 'en-US'

module HealthcarePhony
end

# frozen_string_literal: true

module HealthcarePhony
  class Patient
    attr_accessor :names,
                  :medical_record_number,
                  :account_number,
                  :addresses,
                  :date_of_birth,
                  :gender,
                  :races,
                  :home_phone, # TODO: allow for > 1
                  :cell_phone, # TODO: allow for > 1
                  :work_phone, # TODO: allow for > 1
                  :email,
                  :language,
                  :marital_status,
                  :religion,
                  :ssn,
                  :drivers_license,
                  :ethnic_group,
                  :multiple_birth_indicator,
                  :birth_order,
                  :death_indicator,
                  :death_datetime

    def initialize(**init_args)
      define_names(init_args)
      define_addresses(init_args)
      define_phones(init_args)
      define_dob(init_args)
      @gender = Gender.new(init_args)
      define_race(init_args)
      define_other
      define_identifiers
      define_birth_order
      define_death
    end

    private

    def define_names(**init_args)
      names_count = init_args[:names_count].nil? ? 1 : init_args[:names_count]
      @names = []
      while names_count.positive?
        @names.push(PersonName.new)
        names_count -= 1
      end
    end

    def define_addresses(**init_args)
      address_count = init_args[:address_count].nil? ? 1 : init_args[:address_count]
      @addresses = []
      while address_count.positive?
        @addresses.push(Address.new)
        address_count -= 1
      end
    end

    def define_phones(**init_args)
      @home_phone = HomePhoneNumber.new(init_args)
      @cell_phone = CellPhoneNumber.new(init_args)
      @work_phone = WorkPhoneNumber.new(init_args)
    end

    def define_dob(**init_args)
      min_age = init_args[:min_age].nil? ? 1 : init_args[:min_age]
      max_age = init_args[:max_age].nil? ? 99 : init_args[:max_age]
      @date_of_birth = Faker::Date.birthday(min_age: min_age, max_age: max_age)
    end

    def define_race(**init_args)
      races_count = init_args[:race_count].nil? ? 1 : init_args[:race_count]
      @races = []
      while races_count.positive?
        @races.push(Race.new)
        races_count -= 1
      end
    end

    def define_identifiers
      @medical_record_number = Identifier.new(type_code: 'MR')
      @account_number = Identifier.new(type_code: 'AN')
      @ssn = Faker::IDNumber.ssn_valid
    end

    def define_death
      @death_indicator = %w[Y N].sample
      @death_datetime = @death_indicator == 'Y' ? Faker::Time.between(from: @date_of_birth.to_date, to: Time.now) : ''
    end

    def define_birth_order
      @multiple_birth_indicator = %w[Y N].sample
      @birth_order = @multiple_birth_indicator == 'Y' ? /[1-2]/.random_example : ''
    end

    def define_other
      @language = Language.new
      @marital_status = MaritalStatus.new
      @religion = Religion.new
      @ethnic_group = EthnicGroup.new
    end
  end
end

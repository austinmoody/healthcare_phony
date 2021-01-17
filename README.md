# HealthcarePhony

This is an admittedly _rough_ RubyGem used to generate fake data that can be used in creating test HL7, CSV, or other data for healthcare integration testing. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'healthcare_phony'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install healthcare_phony

## Usage

The general purpose of this gem is to generate various pieces of data useful in creating test healthcare integration data.  Like HL7 messages or CSV files. The high level objects available are:

* Patient
* Patient Visit
* HL7 Message
* Doctor

### Patient

```ruby
patient = Patient.new
```

The above will give you a default Patient object:

```
#<HealthcarePhony::Patient:0x00007fa7ab1b8230
 @account_number=
  #<HealthcarePhony::Identifier:0x00007fa7a9dc3ef0
   @identifier="4969529871",
   @identifier_type_code="AN">,
 @addresses=
  [#<HealthcarePhony::Address:0x00007fa7aeb337f8
    @address_line1="4973 Bruen Square",
    @address_line2="Suite 628",
    @address_type="L",
    @address_type_data_file=nil,
    @city="West Melva",
    @country="",
    @postal_code="48030",
    @set_blank=false,
    @state="MI">],
 @birth_order="",
 @cell_phone=
  #<HealthcarePhony::CellPhoneNumber:0x00007fa7a992d238
   @area_code="641",
   @country_code="++1",
   @equipment_type="CP",
   @equipment_type_data_file=nil,
   @exchange_code="586",
   @set_blank=false,
   @subscriber_number="9470",
   @use_code="ORN",
   @use_code_data_file=nil>,
 @date_of_birth=#<Date: 2005-12-01 ((2453706j,0s,0n),+0s,2299161j)>,
 @death_datetime=2007-11-05 15:24:26 -0500,
 @death_indicator="Y",
 @ethnic_group=
  #<HealthcarePhony::EthnicGroup:0x00007fa7a9d94128
   @code="N",
   @coding_system="HL70189",
   @description="Not Hispanic or Latino",
   @set_blank=false>,
 @gender=
  #<HealthcarePhony::Gender:0x00007fa7a9983458
   @code="U",
   @description="Unknown">,
 @home_phone=
  #<HealthcarePhony::HomePhoneNumber:0x00007fa7a9906cf0
   @area_code="504",
   @country_code="++1",
   @equipment_type="PH",
   @equipment_type_data_file=nil,
   @exchange_code="931",
   @set_blank=false,
   @subscriber_number="8965",
   @use_code="PRN",
   @use_code_data_file=nil>,
 @language=
  #<HealthcarePhony::Language:0x00007fa7a9993c40
   @code="spa",
   @coding_system="HL70296",
   @description="spanish">,
 @marital_status=
  #<HealthcarePhony::MaritalStatus:0x00007fa7a99909f0
   @code="T",
   @coding_system="HL70002",
   @description="Unreported">,
 @medical_record_number=
  #<HealthcarePhony::Identifier:0x00007fa7a9d9d840
   @identifier="5727985905",
   @identifier_type_code="MR">,
 @multiple_birth_indicator="N",
 @names=
  [#<HealthcarePhony::PersonName:0x00007fa7ab1b80f0
    @degree="CPNP",
    @family_name="Murray",
    @gender=nil,
    @given_name="Claude",
    @middle_name="Howe",
    @prefix="Mr.",
    @set_blank=false,
    @suffix="I">],
 @races=
  [#<HealthcarePhony::Race:0x00007fa7a9982eb8
    @code="1002-5",
    @coding_system="",
    @description="American Indian or Alaska Native">],
 @religion=
  #<HealthcarePhony::Religion:0x00007fa7a9d462e8
   @code="PRO",
   @coding_system="HL70006",
   @description="Christian: Protestant">,
 @ssn="320-79-1958",
 @work_phone=
  #<HealthcarePhony::WorkPhoneNumber:0x00007fa7a9959838
   @area_code="508",
   @country_code="++1",
   @equipment_type="PH",
   @equipment_type_data_file=nil,
   @exchange_code="760",
   @set_blank=false,
   @subscriber_number="8916",
   @use_code="WPN",
   @use_code_data_file=nil>>
```

The creation of the Patient can be customized by sending the following parameters when initializing:

* blank &rarr; An integer representing the % of times PatientName components should be blank.
* names_count &rarr; By default one PatientName is generated, this allows you to specify a number > 1.
* address_count &rarr; By default on Address is generated, this allows you to specify a number > 1.
* min_age &rarr; A minimum age (in years) for the Patient. 
* max_age &rarr; A maximum age (in years) for the Patient.
* race_count &rarr; By default on Race is generated, this allows you to specify a number > 1.
* gender &rarr; A Gender object which will be used to generate a Male or Female name if specified.
* degree_data_file &rarr; Location of YAML file containing a list of potential degrees to choose from. By default the gem supplied file will be used.  The default file [degree.yml](https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/degree.yml).

### Patient Visit

```ruby
pv = HealthcarePhony::PatientVisit.new
```

The above will give you a default PatientVisit object:

```
#<HealthcarePhony::PatientVisit:0x00007fcb251055c0
 @admission=
  #<HealthcarePhony::VisitAdmission:0x00007fcb291bc6b8
   @datetime=2021-01-04 05:31:33 -0500,
   @reason="Tempore libero neque voluptatibus.",
   @source="2",
   @type="L">,
 @ambulatory_status="A6",
 @bed_status="K",
 @discharge=
  #<HealthcarePhony::VisitDischarge:0x00007fcb254b7da8
   @datetime=nil,
   @disposition="",
   @location="">,
 @doctors=
  #<HealthcarePhony::VisitDoctors:0x00007fcb251054a8
   @admitting=
    #<HealthcarePhony::Doctor:0x00007fcb29180a50
     @identifier=1777467337,
     @name=
      #<HealthcarePhony::PersonName:0x00007fcb291906f8
       @degree="MD",
       @family_name="King",
       @gender=nil,
       @given_name="Giuseppe",
       @middle_name="Pouros",
       @prefix="Miss",
       @set_blank=false,
       @suffix="Ret.">>,
   @attending=
    #<HealthcarePhony::Doctor:0x00007fcb25105480
     @identifier=1847601659,
     @name=
      #<HealthcarePhony::PersonName:0x00007fcb25125dc0
       @degree="DO",
       @family_name="Breitenberg",
       @gender=nil,
       @given_name="Hailey",
       @middle_name="Beer",
       @prefix="Sen.",
       @set_blank=false,
       @suffix="III">>,
   @consulting=
    #<HealthcarePhony::Doctor:0x00007fcb291730a8
     @identifier=1422794804,
     @name=
      #<HealthcarePhony::PersonName:0x00007fcb29182ee0
       @degree="DO",
       @family_name="McClure",
       @gender=nil,
       @given_name="Raleigh",
       @middle_name="Hettinger",
       @prefix="Rev.",
       @set_blank=false,
       @suffix="JD">>,
   @referring=
    #<HealthcarePhony::Doctor:0x00007fcb29151818
     @identifier=1599337791,
     @name=
      #<HealthcarePhony::PersonName:0x00007fcb29169648
       @degree="MD",
       @family_name="Kreiger",
       @gender=nil,
       @given_name="Pierre",
       @middle_name="Olson",
       @prefix="Fr.",
       @set_blank=false,
       @suffix="PhD">>>,
 @hospital_service="URO",
 @location=
  #<HealthcarePhony::VisitLocation:0x00007fcb2915e220
   @bed="8y3",
   @building="4",
   @description="Numquam officiis placeat voluptatibus.",
   @facility="Ipsam aut non repellat.",
   @floor="81",
   @point_of_care="QFDYRRTIFU",
   @room="243",
   @status="G",
   @type="D">,
 @patient_class="I",
 @patient_type="",
 @readmission_indicator="",
 @vip_indicator="",
 @visit_number=
  #<HealthcarePhony::Identifier:0x00007fcb291c6b68
   @identifier="3738009164",
   @identifier_type_code="VN">>
```

The creation of the PatientVisit can be customized by sending the following parameters when initializing:

* hospital_service &rarr; Array of Hospital Service codes (PV1.10) to randomly choose from.  Specified as comma separated String or Ruby array. Otherwise default HL7 v2.5.1 Table 0069 values are used.
* patient_class &rarr; Array of Patient Class codes (PV1.2) to randomly choose from.  Specified as comma separated String or Ruby array. Otherwise default HL7 v2.5.1 Table 0004 values are used.
* ambulatory_status &rarr; Array of Ambulatory Status codes (PV1.15) to randomly choose from. Specified as comma separated String or Ruby array. Otherwise default HL7 v2.5.1 Table 0009 values are used.
* bed_status &rarr; Array of Bed Status codes (PV1.40) to randomly choose from. Specified as comma separated String or Ruby array.  Otherwise default HL7 v2.5.1 Table 0116 values are used.
* patient_type &rarr; Array of Patient Type codes (PV1.18) to randomly choose from. Specified as comma separated String or Ruby array. Otherwise this field is left blank.
* vip_indicator &rarr; Array of Patient Type codes (PV1.18) to randomly choose from. Specified as comma separated String or Ruby array. Otherwise this field is left blank.
* point_of_care &rarr; Array of potential points of care (PV1.3.1) to randomly choose from. Specified as comma separated String or Ruby array. Otherwise random example generated.
* room &rarr; Array of potential rooms (PV1.3.2) to randomly choose from. Specified as comma separated String or Ruby array.  Otherwise a random 3 digit number is generated.
* bed &rarr; Array of potential beds (PV1.3.3) to randomly choose from. Specified as comma separated String or Ruby array. Otherwise a 3 character sequence is created.
* facility &rarr; Array of potential facility names (PV1.3.4) to randomly choose from. Specified as comma separated String or Ruby array. Otherwise a random string is generated.
* location_status &rarr; Array of potential location statuses (PV1.3.5) to randomly choose from. Specified as comma separated String or Ruby array. Otherwise a random uppercase letter is generated to use.
* person_location_type &rarr; Array of potential person location types (PV1.3.6) to randomly choose from.  Specified as comma separated String or Ruby array. Otherwise values from HL7 v2.5.1 Table 0305 will be used.
* building &rarr; Array of potential building information (PV1.3.7) to randomly choose from. Specified as a comma separated String or Ruby array. Otherwise a random digit 1-9 is used.
* floor &rarr; Array of potential floor information (PV1.3.8) to randomly choose from.  Specified as a comma separated String or Ruby array. Otherwise a random 2 digit number is used.
* location_description &rarr; Array of potential location descriptions (PV1.3.9) to randomly choose from.  Specified as a comma separated String or Ruby array. Otherwise a random string is generated.
* admit_source &rarr; Array of Admit Source codes (PV1.14) to randomly choose from.  Specified as comma separated String or Ruby array. Otherwise default HL7 v2.5.1 Table 0023 values are used.
* admission_type &rarr; Array of Admission Type (PV1.4) to randomly choose from.  Specified as comma separated String or Ruby array. Otherwise default HL7 v2.5.1. Table 0007 values are used.
* admit_reason &rarr; Array of values to use as Admit Reason (PV2.3) to randomly choose from.  Specified as comma separated String or Ruby array.  Otherwise a string of data is generated with Faker::Lorem.sentence
* event_type &rarr; The HL7 trigger event type that this visit is associated with.
* discharge_disposition &rarr; Array of discharge disposition codes (PV1.36) to randomly choose from.  Specified as comma separated String or Ruby array. Otherwise default HL7 v2.5.1 Table 0112 values are used.
* discharge_location &rarr; Array of discharge locations to randomly choose from.  Specified as comma separated String or Ruby array. Otherwise a string of data is generated with Faker::Lorem.sentence
* admit_datetime &rarr; The admit date/time associated with this visit.  If not specified the current date/time is used.

### Hl7 Message

```ruby
hl7 = HealthcarePhony::Hl7Message.new
```

The above will give you a default Hl7Message object:

```
#<HealthcarePhony::Hl7Message:0x00007f81979beb58
 @message_type="MDM",
 @trigger_event="T04",
 @message_control_id="PHONY8408942134",
 @version="2.5.1", @sending_facility="",
 @sending_application="",
 @receiving_application="",
 @receiving_facility="",
 @message_datetime=2021-01-16 20:29:10 -0500,
 @processing_id="P">
```

The creation of the Hl7Message object can be customized by sending the following parameters when initializing:

* message_version - HL7v2 version (MSH.12)
* message_processing_id - Typically P or T (MSH.11)
* message_types - Array of Message Types (MSH.9.1) to randomly choose from.  Specified as comma separated String or Ruby array.
* message_type_file - Location of file containing Message Types (MSH.9.1). If not specified then included [hl7_message_types.yml](https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/hl7_message_types.yml) file will be used.
* message_events - Generic array of Trigger Events (MSH.9.2) to randomly choose from.  Specified as command separated String or Ruby array.
* adt_events - Array of ADT Trigger Events (MSH.9.2) to randomly choose from. Used (if specified) if the Message type for the message is ADT. ADT events from [adt_event_types.yml](https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/adt_event_types.yml) will be used by default.
* oru_events - Array of ORU Trigger Events (MSH.9.2) to randomly choose from. Used (if specified) if the Message type for the message is ORU. ORU events from [oru_event_types.yml](https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/adt_event_types.yml) will be used by default.
* mdm_events - Array of MDM Trigger Events (MSH.9.2) to randomly choose from. Used (if specified) if the Message type for the message is MDM. MDM events from [mdm_event_types.yml](https://github.com/austinmoody/healthcare_phony/blob/main/lib/healthcare_phony/data_files/adt_event_types.yml) will be used by default.
* message_control_id_pattern - Regex pattern used to randomly generate MSH.10 values.  Default is PHONY\d{10} which will generate a value like: PHONY6850295805
* message_sending_facility - Array of Sending Facilities (MSH.4) to randomly choose from.  Specified as comma separated String or Ruby Array.
* message_sending_application - Array of Sending Applications (MSH.3) to randomly choose from.  Specified as comma separated String or Ruby Array.
* message_receiving_application - Array of Receiving Applications (MSH.5) to randomly choose from.  Specified as comma separated String or Ruby Array.
* message_receiving_facility - Array of Receiving Facilities (MSH.6) to randomly choose from.  Specified as comma separated String or Ruby Array.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/austinmoody/healthcare_phony. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/healthcare_phony/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HealthcarePhony project's codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/austinmoody/healthcare_phony/blob/master/CODE_OF_CONDUCT.md).

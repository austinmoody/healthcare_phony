# frozen_string_literal: true

module HealthcarePhony
  class Helper
    class << self
      def random_with_blank(non_blank_value, blank_percentage)
        b_array = [[non_blank_value, (100 - blank_percentage)], ['', blank_percentage]]
        b_array.max_by { |_, weight| rand**100.fdiv(weight) }[0]
      end

      def get_array(input_argument)
        return_array = []

        if !input_argument.nil? && input_argument.instance_of?(Array)
          return_array = input_argument
        elsif !input_argument.nil? && input_argument.instance_of?(String)
          return_array = input_argument.split(',')
        end

        return_array
      end

      def npi_step_one(input)
        # Step 1: Double the value of alternate digits, beginning with the rightmost digit.
        npi = []
        input.to_s.split('').reverse.each_with_index do |n, i|
          npi.push((n.to_i * 2).to_s) if (i + 1).odd?
        end
        npi.reverse!
        total = 0
        npi.join('').split('').each do |x|
          total += x.to_i
        end
        total
      end

      def npi_step_two(input, step_one_total)
        # Step 2:  Add constant 24, to account for the 80840 prefix that would be present on a card issuer identifier,
        # plus the individual digits of products of doubling, plus unaffected digits.
        (24 + step_one_total + double_alternate_digits(input))
      end

      def next_number_end_with_zero(input)
        input += 1 while input.to_s[-1] != '0'
        input
      end

      def double_alternate_digits(npi)
        a_total = 0
        counter = 1
        npi.to_s.split('').each do |n|
          a_total += n.to_i if counter.even?
          counter += 1
        end
        a_total
      end

      def get_npi_check_digit(npi)
        step_one = npi_step_one(npi)

        # Add totals from above two steps + 24
        # c_total = 24 + a_total + b_total
        step_two = npi_step_two(npi, step_one)

        next_high = next_number_end_with_zero(step_two)

        # Step 3:  Subtract from next higher number ending in zero.
        (next_high - step_two)
      end
    end
  end
end

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

        if !input_argument.nil? && input_argument.class == Array
          return_array = input_argument
        elsif !input_argument.nil? && input_argument.class == String
          return_array = input_argument.split(',')
        end

        return_array
      end

      def double_alternate_digits(npi)
        # Double the value of alternate digits, beginning with the rightmost digit... then add them together
        b_npi = []
        npi.to_s.split('').reverse.each_with_index do |n, i|
          b_npi.push((n.to_i * 2).to_s) if (i + 1).odd?
        end
        b_npi.reverse!
        b_total = 0
        b_npi.join('').split('').each do |x|
          b_total += x.to_i
        end
        b_total
      end

      def get_yaml_contents(file_path)
        YAML.safe_load(File.read(file_path), [Symbol])
      end

      def get_npi_check_digit(npi)
        a_npi = npi.to_s.split('')

        # Double the value of alternate digits, beginning with the rightmost digit... then add them together
        b_npi = []
        counter = 1
        a_npi.reverse.each do |n|
          if counter.odd?
            b_npi.push((n.to_i * 2).to_s)
          end
          counter += 1
        end

        b_npi.reverse!

        b_total = 0
        b_npi.join("").split("").each do |x|
          b_total += x.to_i
        end

        # Add up unaffected digits from above step
        a_total = 0
        counter = 1
        a_npi.each do |n|
          if counter.even?
            a_total += n.to_i
          end
          counter += 1
        end

        # Add totals from above two steps + 24
        c_total = 24 + a_total + b_total

        # Get next highest # that ends w/ 0 from above total
        n_total = c_total
        while (n_total.to_s[-1] != "0")
          n_total += 1
        end
        next_high = n_total

        return (next_high - c_total)

      end
    end
  end
end

# frozen_string_literal: true

require 'socket'
require 'healthcare_phony'
require 'optparse'
require 'psych'

class PhonyAdtSender
  attr_reader :host, :port, :number_messages, :message_parameters, :mllp_start, :mllp_end

  def initialize
    @message_parameters = {}
    parse
  end

  def send
    puts "Sending #{@number_messages} messages to #{@host}:#{@port}"

    @number_messages.to_i.times do
      t = TCPSocket.new(@host, @port)

      m = HealthcarePhony::Adt.new(@message_parameters)
      # #{@mllp_start}
      t.send "#{[@mllp_start].pack("H*")}#{m.to_s}#{[@mllp_end].pack("H*")}", 0

      pp "Message With ID #{m.hl7_message.message_control_id} sent..."

      reading_response = true
      ack_response = ''
      while reading_response
        current_read = t.read(1)
        ack_response += current_read unless current_read.nil?
        reading_response = false if current_read.nil?
      end

      pp "ACK: #{ack_response}"

      t.close
    end
  end

  private

  def parse
    options = {}
    optparse = OptionParser.new do |parser|
      parser.banner = 'Usage: phony_adt_sender.rb [options]'
      parser.separator ''

      parser.on('-n', '--number NUMBER', Integer, 'Number of messages to send') do |number_messages|
        options[:number_messages] = number_messages
      end

      parser.on('-h', '--host HOST', String, 'IP or DNS for listening host') do |host|
        options[:host] = host
      end

      parser.on('-p', '--port PORT', Integer, 'Listening port') do |port|
        options[:port] = port
      end

      parser.on('-c', '--config CONFIGFILE', String, 'Path to configuration file (YAML) for message parameters') do |config|
        options[:config] = config
      end

      parser.on('--mllp-start HEX',
                'Hex character(s) to denote start of message bytes. In form nn (example 0b for vertical tab) or nnnn (example 1c0d for file separator & carriage return)') do |mllp_start|
        options[:mllp_start] = mllp_start
      end

      parser.on('--mllp-end HEX', String,
                'Hex character(s) to denote start of message bytes. In form nn (example 0b for vertical tab) or nnnn (example 1c0d for file separator & carriage return)') do |mllp_end|
        options[:mllp_end] = mllp_end
      end

      parser.on('--help', 'Show this message') do
        puts parser
        exit
      end
    end

    begin
      optparse.parse!
      mandatory = %i[host port number_messages]
      missing = mandatory.select { |param| options[param].nil? }
      raise OptionParser::MissingArgument, missing.join(', ') unless missing.empty?
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument
      puts $!.to_s
      puts optparse
      exit
    end

    @host = options[:host]
    @port = options[:port]
    @number_messages = options[:number_messages]
    @message_parameters = Psych.load_file(options[:config]) unless options[:config].nil?
    @mllp_start = if options[:mllp_start].nil?
                    '0b'
                  else
                    options[:mllp_start]
                  end
    @mllp_end = if options[:mllp_end].nil?
                  '1c0d'
                else
                  options[:mllp_end]
                end
  end
end

pas = PhonyAdtSender.new
pas.send

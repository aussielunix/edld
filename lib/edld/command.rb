#!/usr/bin/env ruby

require 'daemons'
require 'serialport'
require 'xmlsimple'

module Edld
  class DataLogger < ::Escort::ActionCommand::Base
    def execute
      Escort::Logger.output.puts "Command: #{command_name}"
      Escort::Logger.output.puts "Options: #{options}"
      Escort::Logger.output.puts "Command options: #{command_options}"
      Escort::Logger.output.puts "Arguments: #{arguments}"
      if config
        Escort::Logger.output.puts "User config: #{config}"
      end

      port_str = "/dev/ttyUSB0"
      baud_rate = 57600
      data_bits = 8
      stop_bits = 1
      parity = SerialPort::NONE

      begin
        sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
        Escort::Logger.output.puts "Connected to #{port_str}"
      rescue
        Escort::Logger.output.puts "Something went wrong"
        exit 1
      end

      loop {
        raw_data  = sp.read
        unless raw_data == ''
          data      = XmlSimple.xml_in(raw_data)
          src       = data['src'].first
          dsb       = data['dsb'].first
          time      = data['time'].first
          tmpr      = data['tmpr'].first
          sensor    = data['sensor'].first
          id        = data['id'].first
          type      = data['type'].first
          ch1watts  = data['ch1'].map { |w| w['watts'].first }.first

          Escort::Logger.output.puts "At #{time} #{ch1watts} was being consumed with a temperature of #{tmpr}"
        end
        sleep 1
      }
    end
  end
end

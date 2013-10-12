#!/usr/bin/env ruby

require 'daemons'
require 'yell'
require 'serialport'
require 'xmlsimple'


# global logger
# this will:
# * log debug and higher to STDOUT
# * log error/fatal to STDERR
# * log info and higher to production.log
# 
@logger = Yell.new do |l|
  l.level = :debug
  l.adapter :file, 'production.log', :level => Yell.level.gte(:info)
  l.adapter STDOUT, level: [:debug, :info, :warn]
  l.adapter STDERR, level: [:error, :fatal]
end

port_str = "/dev/ttyUSB0"
baud_rate = 57600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE


# Become a daemon
Daemons.daemonize

begin
  sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
  @logger.info("Connected to #{port_str}")
rescue
  @logger.fatal("Something went wrong")
  exit 1
end


## The server loop
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

    @logger.info("At #{time} #{ch1watts} watts of energy was being consumed with a room temperature of #{tmpr}")
  end
  sleep 1
}


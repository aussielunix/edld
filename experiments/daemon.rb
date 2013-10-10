#!/usr/bin/env ruby

require 'daemons'
require 'yell'
require 'serialport'


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

port_str = "/dev/ttyUSB0"  #may be different for you
baud_rate = 57600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

# Become a daemon
Daemons.daemonize

# The server loop
loop {
  data = sp.read
  @logger.info(data) unless data == ""
  sleep 1
}

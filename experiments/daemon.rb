#!/usr/bin/env ruby

require 'daemons'
require 'yell'

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


# Become a daemon
Daemons.daemonize

# The server loop
loop {
  @logger.info("info message")
  @logger.debug("debug message")
  @logger.error("an error occured")
  sleep 2
}

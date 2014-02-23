module Edld
  class DataLogger
    include Observable

    def run

      daemon_options = {
        :ontop    => Edld::Config.foreground,
        :app_name => 'edld',
        :dir      => '/var/run/edld',
        :dir_mode => :normal
      }

      Daemons.daemonize(daemon_options)

      # TODO: move to a config file
      #
      port_str   = Edld::Config.serial_port
      baud_rate  = 57600
      data_bits  = 8
      stop_bits  = 1
      parity     = SerialPort::NONE

      # connect to serial port
      #
      begin
        sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
        Edld::Log.debug "Connected to #{port_str}"
      rescue => e
        Edld::Log.fatal "Something went wrong connecting to #{port_str}"
        Edld::Log.debug e
        exit 1
      end

      # loop for ever reading the serial port
      #
      loop {
        raw_data  = sp.readline.chomp!
        unless raw_data == ''
          data      = XmlSimple.xml_in(raw_data)
          Edld::Log.debug "Edld::DataLogger raw data dump #{data.inspect}"
          changed
          notify_observers(data)
        end
        sleep 1
      }
    end
  end
end

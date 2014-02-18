module Edld
  class DataLogger
    def run
      Daemons.daemonize if Edld::Config.foreground == false
        serial_port = {
          :port_str   => Edld::Config.serial_port,
          :baud_rate  => 57600,
          :data_bits  => 8,
          :stop_bits  => 1,
          :parity     => SerialPort::NONE
        }

      begin
        sp = SerialPort.new(serial_port)
        Edld::Log.debug "Connected to #{port_str}"
      rescue
        Edld::Log.fatal "Something went wrong"
        exit 1
      end
      loop {
        raw_data  = sp.readline.chomp!
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

          Edld::Log.debug "raw data dump #{data.inspect}"
          Edld::Log.debug "src: #{src}"
          Edld::Log.debug "dsb: #{dsb}"
          Edld::Log.debug "sensor: #{sensor}"
          Edld::Log.debug "id: #{id}"
          Edld::Log.debug "type: #{type}"
          Edld::Log.info "At #{time} #{ch1watts} was being consumed with a temperature of #{tmpr}"
        end
        sleep 1
      }
    end
  end
end

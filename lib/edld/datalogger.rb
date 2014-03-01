module Edld
  class DataLogger
    include Observable

    def initialize(input, protocol)
      @input    = input
      @protocol = protocol

      Edld::Log.debug "Edld::DataLogger instanciated with an input of #{input.port} and a protocol of #{protocol.name}."
    end

    def run
      daemon_options = {
        :ontop    => Edld::Config.foreground,
        :app_name => 'edld',
        :dir      => '/var/run/edld',
        :dir_mode => :normal
      }
      #TODO: look at Daemonize#run_proc
      #TODO: http://daemons.rubyforge.org/Daemons.html
      Daemons.daemonize(daemon_options)


      # TODO: loop forever reading input and notifying observers
      loop {
        @input.get
        sleep 5
      }
    end
  end
end

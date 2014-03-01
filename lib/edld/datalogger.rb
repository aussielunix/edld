module Edld
  class DataLogger
    include Observable

    def initialize(source, protocol)
      @source   = source
      @protocol = protocol

      Edld::Log.debug "Edld::DataLogger instanciated with a source of #{source.port} and a protocol of #{protocol.name}."
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


      # TODO: loop forever reading source and notifying observers
      loop {
        @source.get
        sleep 5
      }
    end
  end
end

module Edld
  class CLI
    include Mixlib::CLI
    include Edld::Shellout

    option :log_level,
      :short => "-l LEVEL",
      :long  => "--log_level LEVEL",
      :description => "Set the log level (debug, info, warn, error, fatal)",
      :required => false,
      :proc => Proc.new { |l| l.to_sym }

    option :help,
      :short => "-h",
      :long => "--help",
      :description => "Show this message",
      :on => :tail,
      :boolean => true,
      :show_options => true,
      :exit => 0

    option :foreground,
      :short        => '-F',
      :long         => '--foreground',
      :description  => 'Run the app in the foreground (do not daemonize)',
      :boolean      => true,
      :default      => false

    def run(argv=ARGV)
      parse_options(argv)
      ::Edld::Config.merge!(config)
      ::Edld::Config.from_file(::Edld::Config.config_file)

      ::Edld::Log.level = Edld::Config.log_level

      source      = ::Edld::Source.factory(::Edld::Config.source).new
      protocol    = ::Edld::Protocol::CurrentCost.new(source)
      datalogger  = ::Edld::DataLogger.new(source, protocol)

      datalogger.add_observer(Edld::Output::Debug.new) if ::Edld::Config.log_level == 'debug'
      datalogger.add_observer(Edld::Output::Syslog.new)
      datalogger.run
    end
  end
end

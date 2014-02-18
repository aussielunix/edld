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

    option :serial_port,
      :short        => '-s',
      :long         => '--port PORT',
      :description  => 'serial port to connect to [/dev/ttyUSB0]',
      :required     => true,
      :default      => '/dev/ttyUSB0'

    def run(argv=ARGV)
      parse_options(argv)
      ::Edld::Config.merge!(config)

      ::Edld::Log.level = Edld::Config.log_level

      ::Edld::DataLogger.new.run
    end
  end
end

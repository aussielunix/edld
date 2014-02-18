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

    def run(argv=ARGV)
      parse_options(argv)
      ::Edld::Config.merge!(config)

      ::Edld::Log.level = Edld::Config.log_level

      ## provided by Edld::Shellout
      # it will return stdout,stderr if you want them
      #
      systemr('/usr/bin/uptime')
    end
  end
end

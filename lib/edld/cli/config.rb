module Edld
  module Config
    extend Mixlib::Config

    default :log_level, :warn
    default :config_file, "#{ENV['HOME']}/.edld.conf"
    default :serial_port, '/dev/ttyUSB0'
    default :foreground, false

    config_strict_mode true
  end
end

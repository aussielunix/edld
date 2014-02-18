module Edld
  module Config
    extend Mixlib::Config

    default :log_level, :warn
    default :config_file, "#{ENV['HOME']}/.edld.conf"
    config_strict_mode false
  end
end

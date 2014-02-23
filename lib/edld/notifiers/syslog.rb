module Edld
  module Notifier
    class Syslog
      def update(data)
        #FIXME: need to fix for 3-phase sensors
        #
        ch1watts  = data['ch1'].map { |w| w['watts'].first }.first
        Edld::Log.info "Edld::Notifier::Syslog At #{data["time"].first} #{ch1watts} Watts was being consumed with an indoor temperature of #{data["tmpr"].first}\u00B0C"
      end
    end
  end
end

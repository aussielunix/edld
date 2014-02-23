module Edld
  module Notifier
    class Debug
      def update(data)
        Edld::Log.debug "Edld::Notifier::Debug raw data dump #{data.inspect}"
      end
    end
  end
end

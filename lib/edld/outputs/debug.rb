module Edld
  module Output
    class Debug
      def update(data)
        Edld::Log.debug "Edld::output::Debug raw data dump #{data.inspect}"
      end
    end
  end
end

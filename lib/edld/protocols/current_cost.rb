module Edld
  class Protocol
    class Currentcost
      include Observable

      attr_reader  :name

      def initialize
        @port = ::Edld::Config.port
        @name = 'CurrentCost'
        Edld::Log.debug "Processing #{@name} data from #{@port}"
      end

      def get
        @port.get
      end
    end
  end
end

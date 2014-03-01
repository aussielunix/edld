module Edld
  class Source
    class Serial
      def initialize
        @port = ::Edld::Config.port
        Edld::Log.debug "Connected to #{@port}"
      end

      attr_reader :port

      def get
        #get data from port
        #return @data
        #
        Edld::Log.debug "reading data from #{@port}"
      end
    end
  end
end

module Edld
  module Input
    class Serial
      def initialize(port)
        Edld::Log.debug "Connected to #{port}"
        @port = port
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

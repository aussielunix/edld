module Edld
  module Protocol
    class CurrentCost
      include Observable

      attr_reader  :name

      def initialize(port)
        @port = port
        @name = 'CurrentCost'
      end

      def get
        @port.get
      end
    end
  end
end

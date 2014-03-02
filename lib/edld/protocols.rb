require 'edld/protocols/current_cost'

module Edld
  class Protocol
    def self.factory(protocol)
      class_name = protocol.to_s.strip.capitalize
      raise(ArgumentError, "You must provide the name of the protocol") unless class_name
      ::Edld::Protocol.const_get(class_name)
    end
  end
end


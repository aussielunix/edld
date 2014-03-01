require 'edld/sources/serial'

module Edld
  class Source
    def self.factory(source)
      class_name = source.to_s.strip.capitalize
      raise(ArgumentError, "You must provide the name of the source") unless class_name
      ::Edld::Source.const_get(class_name)
    end
  end
end


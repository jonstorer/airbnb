module Airbnb
  module Lib
    module Property
      extend ActiveSupport::Concern

      included do
        property :id, :type => Integer
      end

      module ClassMethods
        def property(name, options = {})
          define_method name do
            update if @_attributes.send(name).nil?
            @_attributes[name]
          end
        end
      end

      def initialize(attributes = {})
        @_attributes = Hashie::Mash.new(attributes)
      end
    end
  end
end

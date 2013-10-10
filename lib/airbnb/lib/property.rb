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
            update if @attributes.send(name).nil?
            @attributes[name]
          end
        end

      end

      def initialize(attributes = {})
        @attributes ||= Hashie::Mash.new
        @attributes.merge!(attributes)
      end
    end
  end
end

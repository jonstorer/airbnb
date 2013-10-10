module Airbnb
  module Lib
    module Resource
      extend ActiveSupport::Concern

      included do
        @base_name = self.name.split('::').last.downcase

        @routes = Hashie::Mash.new({
          :list => "/#{@base_name}s",
          :show => "/#{@base_name}"
        })
      end

      module ClassMethods
        def resource(&block)
          block.call(@routes)
        end
      end

    end
  end
end


module Airbnb
  module Lib
    module Routes
      extend ActiveSupport::Concern

      module ClassMethods
        def resources(name)

          self.class.instance_eval do

            define_method "#{name}s_path" do
              "/#{name}s/search"
            end

            define_method "#{name}_path" do |record|
              "/#{name}s/#{record.id}"
            end

          end

        end
      end

    end
  end
end

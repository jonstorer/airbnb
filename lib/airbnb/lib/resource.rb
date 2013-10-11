module Airbnb
  module Lib
    module Resource
      extend ActiveSupport::Concern

      included do
        cattr_accessor :base_name

        self.base_name           = self.name.split('::').last.downcase
        @_search_options         = []
        @_default_search_options = Hashie::Mash.new

        include Lib::Routes
        resources base_name
      end

      module ClassMethods

        def search_option(parameter, options = {})
          @_search_options << parameter.to_s
          @_default_search_options[parameter] = options[:default] if options.has_key?(:default)
        end

        def find(id)
          new get(self.class.send(:"#{self.base_name}_path", id))[self.base_name]
        end

        def count(params = {})
          data(params)["#{base_name}s_count"]
        end

        def fetch(params = {})
          data(params)["#{base_name}s"].map do |record|
            new(record["#{base_name}"])
          end
        end

        def data(params = {})
          options  = @_default_search_options.merge(params)

          per_page = params[:per_page] || 10
          page     = params[:page]     || 1
          offset   = ( per_page * (page - 1) )

          options[:offset]         = offset
          options[:items_per_page] = per_page

          options = sanatize options, @_search_options

          self.get(self.send(:"#{self.base_name}s_path"), options)
        end
      end

      def update
        write_attributes get(self.class.send(:"#{self.class.base_name}_path", self))[self.class.base_name]
      end

      def write_attributes(attributes = {})
        @_attributes.merge!(attributes)
      end

    end
  end
end

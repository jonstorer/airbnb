module Airbnb
  module Lib
    module Property
      extend ActiveSupport::Concern

      included do
        @_search_options         = []
        @_default_search_options = {}

        base = self.name.split('::').last.downcase
        @routes = Hashie::Mash.new({
          :list => "/#{base}s",
          :show => "/#{base}"
        })

        property :id, :type => Integer
      end

      module ClassMethods

        def resource(&block)
          block.call(@routes)
        end

        def search_option(parameter, options = {})
          @_search_options << parameter
          @_default_search_options[parameter] = options[:default] if options.has_key?(:default)
        end

        def property(name, options = {})
          define_method name do
            update if @attributes.send(name).nil?
            @attributes[name]
          end
        end

        def count(params = {})
          data(params).listings_count
        end

        def fetch(params = {})
          params = { :per_page => 10, :page => 1 }.merge(params)
          data(params).listings.map{ |listing| new(listing.listing) }
        end

        def data(params = {})
          options  = @_default_search_options.merge(params)

          per_page = params[:per_page] || 10
          page     = params[:page]     || 1
          offset   = ( per_page * (page - 1) )

          options[:offset]         = offset
          options[:items_per_page] = per_page

          options = sanatize options, @_search_options

          self.get(@routes.list, options)
        end
      end

      def initialize(attributes = {})
        @attributes ||= Hashie::Mash.new
        @attributes.merge!(attributes)
      end

      private

      def update
      #  write_attributes get("/listings/#{id}").listing
      end

      def write_attributes(attributes = {})
        @attributes.merge!(attributes)
      end
    end
  end
end

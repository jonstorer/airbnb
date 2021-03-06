module Airbnb
  module Lib
    module Resource
      extend ActiveSupport::Concern

      included do
        cattr_accessor :base_name, :search_options, :default_search_options

        self.base_name              = self.name.split('::').last.downcase
        self.search_options         = []
        self.default_search_options = Hashie::Mash.new

        resources base_name

        identifier :id, :type => Integer
      end

      module ClassMethods

        def resources(name)
          self.class.instance_eval do
            define_method "#{name}s_path" do
              "/#{name}s/search"
            end

            define_method "#{name}_path" do |record_or_id|
              id = record_or_id.respond_to?(:id) ? record_or_id.id : record_or_id
              "/#{name}s/#{id}"
            end
          end
        end

        def property(name, options = {})
          define_method name do
            update if @attributes[name].nil?
            @attributes[name]
          end
        end

        def identifier(name, options = {})
          define_method name do
            @attributes[name] || raise(Airbnb::RecordIdentifierNotFound)
          end
        end

        #TODO rename to search_param
        def search_option(parameter, options = {})
          self.search_options << parameter.to_s
          self.default_search_options[parameter] = options[:default] if options.has_key?(:default)
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
          options  = self.default_search_options.merge(params)

          per_page = params[:per_page] || 10
          page     = params[:page]     || 1
          offset   = ( per_page * (page - 1) )

          options[:offset]         = offset
          options[:items_per_page] = per_page

          options = sanatize options, self.search_options

          self.get(self.send(:"#{self.base_name}s_path"), options)
        end
      end

      def update
        write_attributes get(self.class.send(:"#{self.class.base_name}_path", self))[self.class.base_name]
      end

      def write_attributes(attributes = {})
        @attributes.merge!(attributes)
      end

      def initialize(attributes = {})
        @attributes = Hashie::Mash.new(attributes)
      end

    end
  end
end

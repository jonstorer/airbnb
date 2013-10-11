module Airbnb
  module Lib
    class Routes
      def initialize(base_name)
        @base_name = base_name
      end

      def list(scope_or_nil=nil)
        @list ||= "/#{@base_name}s"
        @list = [@list, scope_or_nil].compact.join('/')
        @list
      end

      def show(scope_or_nil=nil)
        @show ||= "/#{@base_name}"
        @show = [@show, scope_or_nil].compact.join('/')
        @show
      end
    end
  end
end

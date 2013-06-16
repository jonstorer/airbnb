module Airbnb
  class Property < Base
    attr_reader :id, :error

    ATTRIBUTES = [
      :address,
      :amenities,
      :amenities_ids,
      :bathrooms,
      :bed_type,
      :bedrooms,
      :beds,
      :calendar_updated_at,
      :cancel_policy,
      :cancel_policy_short_str,
      :cancellation_policy,
      :check_in_time,
      :check_out_time,
      :city,
      :country,
      :country_code,
      :description,
      :error,
      :guests_included,
      :hosting_native_currency,
      :hosting_price_native,
      :house_rules,
      :instant_bookable,
      :is_location_exact,
      :lat,
      :license,
      :lng,
      :max_nights,
      :max_nights_input_value,
      :min_nights,
      :min_nights_input_value,
      :monthly_price_native,
      :name,
      :native_currency,
      :neighborhood,
      :person_capacity,
      :photos,
      :picture_captions,
      :picture_count,
      :price,
      :price_for_extra_person_native,
      :price_formatted,
      :price_native,
      :property_type,
      :property_type_id,
      :recent_review,
      :require_guest_phone_verification,
      :require_guest_profile_picture,
      :requires_license,
      :reviews_count,
      :room_type,
      :room_type_category,
      :security_deposit,
      :security_deposit_formatted,
      :security_deposit_native,
      :security_price_native,
      :smart_location,
      :square_feet,
      :state,
      :thumbnail_url,
      :user,
      :user_id,
      :weekly_price_native,
      :zipcode
    ]

    def self.count
      data.listings_count
    end

    def self.fetch(params = {})
      params = { :per_page => 50, :page => 1 }.merge(params)
      data(params).listings.map{ |listing| new(listing.listing) }
    end

    def initialize(attributes)
      @id    = attributes.id
      @error = attributes.error

      raise ArgumentError.new('id is required') if @error.nil? && @id.nil?

      ATTRIBUTES.each do |key|
        instance_variable_set("@#{key}", attributes[key])
      end
    end

    ATTRIBUTES.each do |key|
      define_method key do
        instance_variable_get("@#{key}") || update && instance_variable_get("@#{key}")
      end
    end

    private

    def update
      attributes = get("/listings/#{@id}").listing
      ATTRIBUTES.each do |key|
        instance_variable_set("@#{key}", attributes[key]) unless instance_variable_get("@#{key}")
      end
    end

    def self.data(params = {})
      per_page = params[:per_page] || 20
      page     = params[:page]     || 1

      options = {
        :offset         => ( per_page * (page - 1) ),
        :items_per_page => per_page
      }

      response = self.get('/listings/search', options).parsed_response

      if response.is_a?(String)
        response = {
          :listings_count => 0,
          :listings => [
            {
              :listing => {
                :error => response.strip
              }
            }
          ]
        }
      end
      Hashie::Mash.new(response)
    end
  end
end

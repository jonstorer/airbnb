module Airbnb
  class Property < Base

    ATTRIBUTES = [
      :address,
      :bed_type,
      :bedrooms,
      :beds,
      :cancellation_policy,
      :city,
      :country,
      :country_code,
      :id,
      :thumbnail_url,
      :instant_bookable,
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
      :license,
      :lng,
      :lat,
      :is_location_exact,
      :house_rules,
      :user_id,
      :user,
      :weekly_price_native,
      :zipcode,
      :description,
      :guests_included,
      :hosting_native_currency,
      :hosting_price_native,
      :check_in_time,
      :check_out_time,
      :amenities,
      :amenities_ids,
      :bathrooms,
      :calendar_updated_at,
      :cancel_policy,
      :cancel_policy_short_str
    ]

    def self.count
      data.listings_count
    end

    def self.fetch(params = {})
      params = { :per_page => 50, :page => 1 }.merge(params)
      data(params).listings.map{ |listing| new(listing.listing) }
    end

    def initialize(attributes)
      ATTRIBUTES.each do |key|
        instance_variable_set("@#{key}", attributes[key])
      end
    end

    ATTRIBUTES.each do |key|
      define_method key do
        instance_variable_get("@#{key}") || update && instance_variable_get("@#{key}")
      end
    end

    def latitude
      @lat
    end

    def longitude
      @lng
    end

    def picture_url(size = :small)
      "https://a2.muscache.com/pictures/#{cover_photo_id}/#{size}.jpg"
    end

    private

    def cover_photo_id
      @thumbnail_url.match(/\/(\d+)\//)[1]
    end

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
      Hashie::Mash.new(self.get('/listings/search', options))
    end
  end
end

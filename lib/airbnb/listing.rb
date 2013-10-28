module Airbnb
  class Listing < Base
    include Lib::Resource

    search_option :items_per_page,   :default => 20
    search_option :offset,           :default => 0
    search_option :location,         :default => nil
    search_option :number_of_guests, :default => 1
    search_option :checkin_in
    search_option :checkin_out
    search_option :room_types
    search_option :min_beds
    search_option :min_bedrooms
    search_option :min_bathrooms
    search_option :price_min
    search_option :price_max

    property :address
    property :bathrooms
    property :bed_type
    property :bedrooms
    property :beds
    property :calendar_updated_at
    property :cancel_policy
    property :cancel_policy_short_str
    property :cancellation_policy
    property :check_in_time
    property :check_out_time
    property :city
    property :country
    property :country_code
    property :description
    property :guests_included
    property :hosting_native_currency
    property :hosting_price_native
    property :house_rules
    property :instant_bookable
    property :is_location_exact
    property :lat
    property :lng
    property :license
    property :max_nights
    property :max_nights_input_value
    property :min_nights
    property :min_nights_input_value
    property :monthly_price_native
    property :name
    property :native_currency
    property :neighborhood
    property :person_capacity
    property :photos
    property :picture_captions
    property :picture_count
    property :price
    property :price_for_extra_person_native
    property :price_formatted
    property :price_native
    property :recent_review
    property :require_guest_phone_verification
    property :require_guest_profile_picture
    property :requires_license
    property :reviews_count
    property :room_type
    property :room_type_category
    property :security_deposit
    property :security_deposit_formatted
    property :security_deposit_native
    property :security_price_native
    property :smart_location
    property :square_feet
    property :state
    property :thumbnail_url
    property :weekly_price_native
    property :zipcode

    property :amenities
    property :amenities_ids

    property :property_type
    property :property_type_id

    property :user
    property :user_id

    def available?(checkin, checkout, number_of_guests)
      raise InvalidDateRange   if checkin > checkout
      raise UnderMinimumNights if min_nights > (checkout - checkin).to_i
      raise OverMaximumNights  if (checkout - checkin).to_i >= max_nights
      raise OverPersonCapacity if number_of_guests > person_capacity

      options = { :checkin => checkin, :checkout => checkout, :number_of_guests => number_of_guests }
      get("/listings/#{id}/available", options).result
    end
  end
end

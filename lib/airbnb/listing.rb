module Airbnb
  class Listing < Base
    include Lib::Resource
    include Lib::Property

    #TODO: remove this
    routes do
      list 'search'
    end

    #TODO rename to search_param
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

    #TODO do something with :type
    property :address
    property :bathrooms
    property :bed_type
    property :bedrooms,                        :type => Integer
    property :beds,                            :type => Integer
    property :calendar_updated_at,             :type => DateTime
    property :cancel_policy
    property :cancel_policy_short_str
    property :cancellation_policy
    property :check_in_time,                   :type => DateTime
    property :check_out_time,                  :type => DateTime
    property :city
    property :country
    property :country_code
    property :description
    property :guests_included, :type => Integer
    property :hosting_native_currency
    property :hosting_price_native, :type => Integer
    property :house_rules
    property :instant_bookable,  :type => Boolean
    property :is_location_exact, :type => Boolean
    property :lat, :type => Float
    property :lng, :type => Float
    property :license
    property :max_nights, :type => Integer
    property :max_nights_input_value
    property :min_nights, :type => Integer
    property :min_nights_input_value
    property :monthly_price_native
    property :name
    property :native_currency
    property :neighborhood
    property :person_capacity, :type => Integer
    property :photos
    property :picture_captions
    property :picture_count, :type => Integer
    property :price, :type => Integer
    property :price_for_extra_person_native, :type => Integer
    property :price_formatted
    property :price_native
    property :recent_review
    property :require_guest_phone_verification
    property :require_guest_profile_picture
    property :requires_license
    property :reviews_count, :type => Integer
    property :room_type
    property :room_type_category
    property :security_deposit, :type => Integer
    property :security_deposit_formatted
    property :security_deposit_native
    property :security_price_native
    property :smart_location
    property :square_feet, :type => Integer
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
  end
end

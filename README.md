Airbnb
===

A library to paginate through properties.

Uses
---

    property = Airbnb.Properties.fetch(:page => 1).first

    property.address                          => '123 Main St.'
    property.amenities                        => [ "Internet",
                                                   "Wireless Internet",
                                                   "Air Conditioning",
                                                   "Kitchen",
                                                   "Buzzer/Wireless Intercom",
                                                   "Heating",
                                                   "Family/Kid Friendly",
                                                   "Washer",
                                                   "Dryer" ]
    property.amenities_ids                    => [3, 4, 5, 8, 28, 30, 31, 33, 34]
    property.bathrooms                        => '1'
    property.bed_type                         => 'Real Bed'
    property.bedrooms                         => '1'
    property.beds                             => '1'
    property.calendar_updated_at              => '3 days ago'
    property.cancel_policy                    => '5'
    property.cancel_policy_short_str          => 'Strict'
    property.cancellation_policy              => 'strict'
    property.check_in_time                    => '14'
    property.check_out_time                   => '12'
    property.city                             => 'New York'
    property.country                          => 'United States'
    property.country_code                     => 'US'
    property.description                      => 'LARGE STUDIO 1 Block from ...'
    property.id                               => 1234
    property.instant_bookable                 => false
    property.is_location_exact                => true
    property.lat                              => 40.75747813141989
    property.latitude                         => 40.75747813141989
    property.license                          => ''
    property.lng                              => -73.99101412904595
    property.longitude                        => -73.99101412904595
    property.max_nights                       => '30'
    property.max_nights_input_value           => '30'
    property.min_nights                       => '1'
    property.min_nights_input_value           => '1'
    property.monthly_price_native             => '4999'
    property.native_currency                  => 'USD'
    property.neighborhood                     => "Hell's Kitchen"
    property.person_capacity                  => 4
    property.picture_count                    => 15
    property.price                            => 99
    property.price_for_extra_person_native    => 0
    property.price_formatted                  => '$99'
    property.price_native                     => 99
    property.property_type                    => 'Apartment'
    property.property_type_id                 => 1
    property.require_guest_phone_verification => false
    property.require_guest_profile_picture    => false
    property.requires_license                 => false
    property.reviews_count                    => 25
    property.room_type                        => 'Entire home/apt'
    property.room_type_category               => 'entire_home'
    property.security_deposit                 => 150
    property.security_deposit_formatted       => '$150'
    property.security_deposit_native          => 150
    property.security_price_native            => 150
    property.smart_location                   => 'New York, NY'
    property.square_feet                      =>
    property.state                            => 'NY'
    property.user_id                          => 1234
    property.weekly_price_native              => ''
    property.zipcode                          => 10036

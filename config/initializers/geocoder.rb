Geokit::Geocoders::MapboxGeocoder.key = ENV["MAPBOX_ACCESS_KEY"] || ""
Geokit::Geocoders::GoogleGeocoder.api_key = ENV["GOOGLE_ACCESS_KEY"] || ""
Geokit::Geocoders::UsGeocoder.key = false
Geokit::Geocoders::provider_order = [:google, :mapbox]

class GeocoderWorker
  include Sidekiq::Worker

  def perform(id)
    voter = Voter.find(id)
    address = "#{voter.address1}, #{voter.city}, #{voter.state} #{voter.zip}"
    latlng = Geokit::Geocoders::MultiGeocoder.geocode address
    voter.latitude = latlng.lat
    voter.longitude = latlng.lng
    voter.save
  end
end

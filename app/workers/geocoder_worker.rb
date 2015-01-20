class GeocoderWorker
  include Sidekiq::Worker

  def perform(id)
    voter = Voter.find(id)
    latlng = Geokit::Geocoders::MultiGeocoder.geocode voter.full_address
    voter.latitude = latlng.lat
    voter.longitude = latlng.lng
    voter.save
  end
end

class Voter < ActiveRecord::Base
  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    "#{address1} #{city}, #{state} #{zip}"
  end

  def geocode
    latlng = Geokit::Geocoders::GoogleGeocoder.geocode full_address
    self.latitude = latlng.lat
    self.longitude = latlng.lng
    latlng
  end

  def valid_coords?
    latitude.class == Float && longitude.class == Float
  end

  validates :first_name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end

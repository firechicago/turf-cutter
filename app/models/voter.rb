class Voter < ActiveRecord::Base
  validates :first_name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  has_many :list_memberships, dependent: :destroy
  has_many :contacts

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    "#{address1} #{city}, #{state} #{zip}"
  end

  def geocode
    GeocoderWorker.perform_async(id) unless Rails.env == "test"
  end

  def valid_coords?
    latitude.class == Float && longitude.class == Float
  end

  def self.import(file)
    success = true
    any_voters = false
    CSV.foreach(file.path, headers: true) do |row|
      voter = Voter.create row.to_hash
      voter.geocode
      success = false if voter.errors.any?
      any_voters = true
    end
    success && any_voters
  end
end

class List < ActiveRecord::Base
  has_many :voters, through: :list_memberships
  has_many :list_memberships, dependent: :destroy
  validates :name, presence: true

  def to_geojson_array
    array = []
    voters.each do |voter|
      next unless voter.valid_coords?
      geojson = {
        type: "Feature", geometry: {
          type: "Point",
          coordinates: [voter.longitude, voter.latitude]
        },
        properties: {
          title: voter.full_name,
          description: voter.full_address,
          voter_id: voter.id,
          "marker-size" => "medium",
          "marker-color" => "#FF0000"
        }
      }
      array << geojson
    end
    array
  end

  def contact_logging_geojson
    array = []
    voters.each do |voter|
      next unless voter.valid_coords?
      geojson = {
        type: "Feature", geometry: {
          type: "Point",
          coordinates: [voter.longitude, voter.latitude]
        },
        properties: {
          title: voter.full_name,
          description: voter.full_address,
          voter_id: voter.id,
          url: "/voters/#{voter.id}/contacts/new",
          "marker-size" => "medium",
          "marker-color" => "#FF0000"
        }
      }
      array << geojson
    end
    array
  end
end

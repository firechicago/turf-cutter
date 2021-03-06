class List < ActiveRecord::Base
  has_many :voters, through: :list_memberships
  has_many :list_memberships, dependent: :destroy
  validates :name, presence: true

  def add_voters(voters)
    memberships = []
    voters.each do |voter|
      memberships << ListMembership.new(voter_id: voter.id, list_id: id)
    end
    ListMembership.import(memberships)
  end

  def turf_cutting_geojson
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

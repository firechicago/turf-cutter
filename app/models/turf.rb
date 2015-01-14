class Turf
  def self.create(params)
    params["lists"].each_value do |turf|
      list = List.new
      list.name = turf["name"]
      if list.save
        turf["voter_ids"].each do |voter_id|
          ListMembership.create!(voter_id: voter_id, list_id: list.id)
        end
      else
        return false
      end
    end
    true
  end
end

namespace :geocode do
  desc "Updates geocoding for any voters in the database without geocoding"
  task update: [:environment] do
    voters = Voter.where("latitude IS NULL OR longitude IS NULL")
    voters.each { |voter| voter.geocode }
  end
end

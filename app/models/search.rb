class Search < ActiveRecord::Base
  def voters
    @voters ||= find_voters
  end

  private

  def find_voters
    voters = Voter.order(:last_name)
    voters = voters.where("first_name like ?", "%#{first_name}%") if first_name.present?
    voters = voters.where("last_name like ?", "%#{last_name}%") if last_name.present?
    voters = voters.where("address1 like ?", "%#{address1}%") if address1.present?
    voters = voters.where("address2 like ?", "%#{address2}%") if address2.present?
    voters = voters.where("city like ?", "%#{city}%") if city.present?
    voters = voters.where("state like ?", "%#{state}%") if state.present?
    voters = voters.where("zip like ?", "%#{zip}%") if zip.present?

    voters
  end
end

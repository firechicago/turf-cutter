class Search < ActiveRecord::Base
  def voters
    @voters ||= find_voters
  end

  def num_voters
    voters.length
  end

  private

  def self.fields
    [
      :first_name,
      :last_name,
      :address1,
      :address2,
      :city,
      :state,
      :zip
    ]
  end

  def find_voters
    voters = nil
    Search.fields.each do |field|
      next unless send(field).present?
      if voters.nil?
        voters = Voter.where("#{field} like ?", "%#{send(field)}%")
      else
        voters = voters.where("#{field} like ?", "%#{send(field)}%")
      end
    end
    voters
  end
end

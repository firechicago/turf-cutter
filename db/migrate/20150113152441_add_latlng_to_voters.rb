class AddLatlngToVoters < ActiveRecord::Migration
  def change
    add_column :voters, :latitude, :float
    add_column :voters, :longitude, :float
  end
end

class CreateListMemberships < ActiveRecord::Migration
  def change
    create_table :list_memberships do |t|
      t.integer :list_id, null: false
      t.integer :voter_id, null: false

      t.timestamps null: false
    end
    add_index :list_memberships, [:list_id, :voter_id], unique: true
  end
end

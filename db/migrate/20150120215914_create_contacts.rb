class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.integer :voter_id, null: false
      t.integer :support
      t.string :outcome
      t.text :note

      t.timestamps null: false
    end
  end
end

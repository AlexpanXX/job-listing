class CreateStartupRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :startup_relationships do |t|
      t.integer :startup_id
      t.integer :user_id

      t.timestamps
    end
  end
end

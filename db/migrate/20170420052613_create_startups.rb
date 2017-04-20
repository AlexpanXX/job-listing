class CreateStartups < ActiveRecord::Migration[5.0]
  def change
    create_table :startups do |t|
      t.string :name
      t.text :description
      t.integer :view_count
      t.integer :favorite_count

      t.timestamps
    end
  end
end

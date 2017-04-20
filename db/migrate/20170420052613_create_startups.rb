class CreateStartups < ActiveRecord::Migration[5.0]
  def change
    create_table :startups do |t|
      t.string :name
      t.string :email
      t.text :description
      t.integer :view_count, default: 0
      t.integer :favorite_count
      t.boolean :is_hidden, default: true

      t.timestamps
    end
  end
end

class AddStartupIdToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :startup_id, :integer
  end
end

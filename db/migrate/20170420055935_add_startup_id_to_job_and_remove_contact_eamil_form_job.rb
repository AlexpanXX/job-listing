class AddStartupIdToJobAndRemoveContactEamilFormJob < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :contact_email
    add_column :jobs, :startup_id, :integer
  end
end

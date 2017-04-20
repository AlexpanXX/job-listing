class StartupRelationship < ApplicationRecord
  belongs_to :startup
  belongs_to :user
end

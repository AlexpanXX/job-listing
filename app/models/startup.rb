class Startup < ApplicationRecord
  validates :title, :description, presence: true

  has_many :jobs
end

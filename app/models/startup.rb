class Startup < ApplicationRecord
  validates :name, :email, :description, presence: true

  has_many :jobs
  has_many :startup_relationships
  has_many :followers, through: :startup_relationships, source: :user

  scope :publish, -> { where(is_hidden: false) }
  scope :recent, -> { order("created_at DESC") }
  scope :by_favorite_count, -> { order("favorite_count DESC")}

  def hide!
    self.is_hidden = true
    self.save!
  end

  def publish!
    self.is_hidden = false
    self.save!
  end
end

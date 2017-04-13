class Job < ApplicationRecord
  validates :title, :wage_lower_bound, :wage_upper_bound, presence: true
  validates :wage_lower_bound, :wage_upper_bound, numericality: { greater_than: 0 }

  has_many :resumes

  scope :recent, -> { order("created_at DESC") }
  scope :by_lower_bound, -> { order("wage_lower_bound DESC")}
  scope :by_upper_bound, -> { order("wage_upper_bound DESC")}

  def hide!
    is_hidden = true
    save!
  end

  def publish!
    is_hidden = false
    save!
  end
end

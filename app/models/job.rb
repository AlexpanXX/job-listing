class Job < ApplicationRecord
  validates :title, :wage_lower_bound, :wage_upper_bound, presence: true
  validates :wage_lower_bound, :wage_upper_bound, numericality: { greater_than: 0 }

  has_many :resumes

  scope :publish, -> { where(is_hidden: false) }
  scope :recent, -> { order("created_at DESC") }
  scope :by_lower_bound, -> { order("wage_lower_bound DESC")}
  scope :by_upper_bound, -> { order("wage_upper_bound DESC")}

  def hide!
    self.is_hidden = true
    self.save!
  end

  def publish!
    self.is_hidden = false
    self.save!
  end
end

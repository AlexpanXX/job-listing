class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :password, presence: true

  has_many :resumes
  has_many :startup_relationships
  has_many :favorited_startups, through: :startup_relationships, source: :startup
  has_many :job_relationships
  has_many :favorited_jobs, through: :job_relationships, source: :job

  scope :recent, -> { order("created_at DESC") }

  def admin?
    is_admin
  end

  def is_follower_of_startup?(startup)
    favorited_startups.include?(startup)
  end

  def favorite_startup!(startup)
    favorited_startups << startup
  end

  def dislikes_startup!(startup)
    favorited_startups.delete(startup)
  end

  def is_follower_of_job?(job)
    favorited_jobs.include?(job)
  end

  def favorite_job!(job)
    favorited_jobs << job
  end

  def dislikes_job!(job)
    favorited_jobs.delete(job)
  end
end

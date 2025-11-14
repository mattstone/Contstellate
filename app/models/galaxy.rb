class Galaxy < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :session_galaxies, dependent: :destroy
  has_many :sessions, through: :session_galaxies

  validates :name, presence: true, uniqueness: true
  validates :color, presence: true
  validates :question_count, numericality: { greater_than_or_equal_to: 0 }

  # Order by creation for consistent display
  default_scope { order(id: :asc) }
end

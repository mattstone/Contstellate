class Session < ApplicationRecord
  has_many :reflections, dependent: :destroy
  has_many :session_galaxies, dependent: :destroy
  has_many :galaxies, through: :session_galaxies
  has_many :questions, through: :reflections

  validates :mode, presence: true, inclusion: { in: %w[solo group] }
  validates :player_count, numericality: { greater_than: 0 }, if: -> { mode == "group" }

  scope :recent, -> { order(started_at: :desc) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :in_progress, -> { where(completed_at: nil) }

  def solo?
    mode == "solo"
  end

  def group?
    mode == "group"
  end

  def complete!
    update(completed_at: Time.current)
  end

  def in_progress?
    completed_at.nil?
  end

  def add_galaxy(galaxy)
    session_galaxies.find_or_create_by(galaxy: galaxy)
    update(galaxies_visited: galaxies.count)
  end
end

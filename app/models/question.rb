class Question < ApplicationRecord
  belongs_to :galaxy
  has_many :reflections, dependent: :destroy

  validates :content, presence: true
  validates :used_count, numericality: { greater_than_or_equal_to: 0 }

  # Get least used questions first for smart rotation
  scope :least_used, -> { order(used_count: :asc) }
  scope :for_galaxy, ->(galaxy) { where(galaxy: galaxy) }

  def mark_as_used!
    increment!(:used_count)
  end
end

class Reflection < ApplicationRecord
  belongs_to :session
  belongs_to :question

  validates :reflection_type, inclusion: { in: %w[note voice both skip], allow_nil: true }

  scope :with_notes, -> { where.not(note: nil).where.not(note: "") }
  scope :with_voice, -> { where.not(voice_recording_url: nil) }
  scope :for_session, ->(session) { where(session: session) }

  def has_content?
    note.present? || voice_recording_url.present?
  end

  def skipped?
    reflection_type == "skip"
  end
end

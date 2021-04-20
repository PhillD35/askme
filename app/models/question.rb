class Question < ApplicationRecord
  TEXT_MAX_LENGTH = 255

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, presence: true, length: { maximum: TEXT_MAX_LENGTH }

  scope :sorted, -> { order(created_at: :desc) }
  scope :answered, -> { where.not(answer: nil) }
  scope :unanswered, -> { where(answer: nil) }
end

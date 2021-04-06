class Question < ApplicationRecord
  TEXT_MAX_LENGTH = 255

  belongs_to :user

  validates :text,
            presence: true,
            length: { maximum: TEXT_MAX_LENGTH }
end

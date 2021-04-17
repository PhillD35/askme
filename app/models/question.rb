class Question < ApplicationRecord
  TEXT_MAX_LENGTH = 255

  belongs_to :user
  belongs_to :author,
             class_name: 'User',
             optional: true

  validates :text,
            presence: true,
            length: { maximum: TEXT_MAX_LENGTH }

  def author_name
    self.author&.username
  end
end

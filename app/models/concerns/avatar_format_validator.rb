class AvatarFormatValidator < ActiveModel::Validator
  URL_SCHEMES = %w[http https]
  ERROR_MESSAGE = 'is invalid. Expected: http://example.com/image.png'.freeze

  def validate(record)
    unless record.avatar_url&.start_with?(*URL_SCHEMES) || record.avatar_url&.empty?
      record.errors.add(:avatar_url, ERROR_MESSAGE)
    end
  end
end

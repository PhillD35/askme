require 'openssl'

class User < ApplicationRecord
  attr_accessor :password

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  URL_SCHEMES = %w[http https]

  USERNAME_FORMAT = /\A[A-Za-z0-9_]+\z/
  USERNAME_MAX_LENGTH = 40

  EMAIL_FORMAT = /\A.+@.+\..+\z/

  has_many :questions

  validates :email, :username,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :username,
            format: { with: USERNAME_FORMAT },
            length: { maximum: USERNAME_MAX_LENGTH }

  validates :email, format: { with: EMAIL_FORMAT }

  validates :password,
            presence: true,
            confirmation: true,
            on: :create

  validates :password_confirmation,
            presence: true,
            on: :create

  before_update :normalize_avatar_url
  before_save :encrypt_password, :downcase_attributes

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    ok_password =
      user.password_hash == User
                              .hash_to_string(
                                OpenSSL::PKCS5
                                .pbkdf2_hmac(
                                             password,
                                             user.password_salt,
                                             ITERATIONS,
                                             DIGEST.length,
                                             DIGEST
                                )
                              )

    return user if ok_password
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def downcase_attributes
    self.email.downcase!
    self.username.downcase!
  end

  def encrypt_password
    return nil unless self.password.present?

    self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

    self.password_hash = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
    )
  end

  def new_question
    self.questions.build
  end

  def normalize_avatar_url
    return if self.avatar_url.start_with?(*URL_SCHEMES) || self.avatar_url.empty?

    self.avatar_url.prepend('https://')
  end

  def sorted_questions
    self.questions.order(created_at: :desc)
  end

  def questions_amount_answered
    self.questions.where.not(answer: nil).count
  end

  def questions_amount_total
    self.questions.count
  end

  def questions_amount_unanswered
    self.questions.where(answer: nil).count
  end
end

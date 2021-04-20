require 'openssl'

class User < ApplicationRecord
  attr_accessor :password

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  USERNAME_FORMAT = /\A[A-Za-z0-9_]+\z/
  USERNAME_MAX_LENGTH = 40

  EMAIL_FORMAT = /\A.+@.+\..+\z/

  BG_COLOR_FORMAT = /\A#[\h]{3}{1,2}\z/

  has_many :questions, dependent: :delete_all

  has_many :asked_questions,
           class_name: 'Question',
           foreign_key: 'author_id',
           dependent: :nullify

  validates_with AvatarFormatValidator, on: :update

  validates :background_color,
            presence: true,
            format: { with: BG_COLOR_FORMAT },
            on: :update

  validates :email, :username,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :email, format: { with: EMAIL_FORMAT }

  validates :username,
            format: { with: USERNAME_FORMAT },
            length: { maximum: USERNAME_MAX_LENGTH }

  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_save :encrypt_password, :downcase_attributes

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    ok_password =
      user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
                                                                           user.password_salt,
                                                                           ITERATIONS,
                                                                           DIGEST.length,
                                                                           DIGEST))

    return user if ok_password
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  private

  def downcase_attributes
    email.downcase!
    username.downcase!
  end

  def encrypt_password
    return nil unless password.present?

    self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

    self.password_hash = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST)
    )
  end
end

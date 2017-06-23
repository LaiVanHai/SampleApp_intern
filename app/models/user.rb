class User < ApplicationRecord
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true,
    length: {maximum: Settings.name_maximum_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_maximum_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password_minimum_length}

  has_secure_password

  private
  def downcase_email
    self.email = email.downcase
  end
end

class User < ApplicationRecord
  # encrypt password
  has_secure_password

  has_many :projects, foreign_key: :user_id
  has_many :logs, foreign_key: :user_id
  # Validations
  validates_presence_of :name, :email, :password_digest
end

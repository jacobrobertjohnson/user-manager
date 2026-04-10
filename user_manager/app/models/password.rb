class Password < ApplicationRecord
  validates :active, presence: true
  validates :password_digest, presence: true
  
  belongs_to :user
  has_secure_password
end

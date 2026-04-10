class User < ApplicationRecord
  validates :active, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :passwords
  has_many :roles
end

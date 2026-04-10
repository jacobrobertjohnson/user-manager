class Role < ApplicationRecord
  validates :name, presence: true
  validates :active, presence: true

  belongs_to :user
end

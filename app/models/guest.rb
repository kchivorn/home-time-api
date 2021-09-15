class Guest < ApplicationRecord
  validates :email, uniqueness: true, presence: true
end

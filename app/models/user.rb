class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true 
  validates :password, length: { minimum: 6 }
  has_secure_password
end

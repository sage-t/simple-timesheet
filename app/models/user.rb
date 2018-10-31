class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :employees, dependent: :destroy
  has_many :companies, through: :employees
end

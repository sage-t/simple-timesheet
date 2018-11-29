class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :employees, dependent: :destroy
  has_many :companies, through: :employees

  def name
    return "#{self.first_name} #{self.last_name}"
  end
end

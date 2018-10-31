class Employee < ApplicationRecord
    belongs_to :company
    belongs_to :user
    has_many :punches, dependent: :destroy
    has_many :pay_periods, through: punches
end

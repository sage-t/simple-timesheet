class Company < ApplicationRecord
    has_many :employees, dependent: :destroy
    has_many :pay_periods, dependent: :destroy
end

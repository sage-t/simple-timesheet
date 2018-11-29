class Company < ApplicationRecord
    has_many :employees, dependent: :destroy
    has_many :pay_periods, dependent: :destroy

    def curr_pay_period
        self.pay_periods.order("created_at DESC").first
    end
end

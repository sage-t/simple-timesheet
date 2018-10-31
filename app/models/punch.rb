class Punch < ApplicationRecord
    belongs_to :employee
    belongs_to :pay_period
end

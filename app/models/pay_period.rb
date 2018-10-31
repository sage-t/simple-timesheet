class PayPeriod < ApplicationRecord
    belongs_to :company
    has_many :punches, dependent: :destroy
end

class PayPeriod < ApplicationRecord
    belongs_to :company
    has_many :punches, dependent: :destroy

    def self.create_first(params, company)
        start_date = Date.new(params[:company]["start_date(1i)"].to_i, params[:company]["start_date(2i)"].to_i, params[:company]["start_date(3i)"].to_i)
        end_date = Date.new(params[:company]["end_date(1i)"].to_i, params[:company]["end_date(2i)"].to_i, params[:company]["end_date(3i)"].to_i)
        pay_period = PayPeriod.new(start_date: start_date, end_date: end_date, company_id: company.id)
        return pay_period.save
    end
end

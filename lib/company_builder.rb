class CompanyBuilder
    attr_reader :errors

    def initialize
        @company = Company.new
        @errors = {}
    end

    def company
        return @company
    end

    def set_name(name)
        @company.name = name
    end

    def set_owner(user_id)
        @user_id = user_id
    end

    def set_pay_period_start(params)
        @start_date = Date.new(params[:company]["start_date(1i)"].to_i, params[:company]["start_date(2i)"].to_i, params[:company]["start_date(3i)"].to_i)
    end

    def set_pay_period_end(params)
        @end_date = Date.new(params[:company]["end_date(1i)"].to_i, params[:company]["end_date(2i)"].to_i, params[:company]["end_date(3i)"].to_i)
    end

    def save
        begin
            @company.save!
        rescue => e
            @errors[:company] = e.message
            return false
        end

        begin
            @pay_period = PayPeriod.new(start_date: @start_date, end_date: @end_date, company_id: @company.id)
            @pay_period.save!
        rescue => e
            @company.destroy
            @errors[:pay_period] = e.message
            return false
        end

        begin
            @owner = Owner.new(company_id: @company.id, user_id: @user_id)
            @owner.save!
        rescue => e
            @company.destroy # Will also destroy the pay period
            @errors[:owner] = e.message
            return false
        end

        return true
    end
end
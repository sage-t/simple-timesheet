class Employee < ApplicationRecord
    belongs_to :company
    belongs_to :user
    has_many :punches, dependent: :destroy
    has_many :pay_periods, through: :punches

    def is_clocked_in
        !self.company.curr_pay_period.punches.where(employee_id: self.id).size.even?
    end

    # Sums clocked in time and outputs human readable string
    def pay_time(pay_period=self.company.curr_pay_period)
        if self.punches.size < 2
            return "0s"
        end

        punches = Array.wrap(self.punches.where(pay_period_id: pay_period.id).order("created_at ASC"))
        time = punches.shift.punched_at - punches.shift.punched_at
        while punches.size > 1 do
            time += punches.shift.punched_at - punches.shift.punched_at
        end

        return self.humanize_time(time.abs)
    end

    # Allows employee to punch in or out
    def punch
        pay_period = self.company.curr_pay_period
        punch_type = if self.is_clocked_in then "Clock out" else "Clock in" end

        Punch.create(punch_type: punch_type, employee_id: self.id, punched_at: DateTime.current(), pay_period_id: pay_period.id)
    end

    def add_employee_form
        ""
    end

    def employee_options(company, employee)
        ""
    end

    def manager_options(company, manager)
        ""
    end

    def delete_company_link
        ""
    end

    def demote(manager)
        raise NotImplementedError
    end

    def promote(employee)
        raise NotImplementedError
    end

    def employ(user_email)
        raise NotImplementedError
    end

    def unemploy(employee)
        raise NotImplementedError
    end

    # Makes time human readable (Xd Xh Xm Xs)
    def humanize_time(seconds)
        [[60, :s], [60, :m], [24, :h], [1000, :d]].map{ |count, name|
            if seconds > 0
                seconds, n = seconds.divmod(count)
                "#{n.to_i}#{name}"
            end
        }.compact.reverse.join(' ')
    end
end

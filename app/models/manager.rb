class Manager < Employee
    def employee_options(company, employee)
        " (#{employee.pay_time}) <strong><a href='/promote?company_id=#{company.id}&employee_id=#{employee.id}' class='button' title='Promote'>↑</a> <a href='/unemploy?company_id=#{company.id}&employee_id=#{employee.id}' class='button' title='Remove'>-</a></strong>".html_safe
    end

    def manager_options(company, manager)
        " (#{manager.pay_time}) <strong><a href='/demote?company_id=#{company.id}&employee_id=#{manager.id}' class='button' title='Demote'>↓</a></strong>".html_safe
    end

    def demote(manager)
        manager.becomes!(Employee)
        manager.type = "Employee"
        manager.save!
    end

    def promote(employee)
        employee.becomes!(Manager).save!
    end

    def employ(user_email)
        user_id = User.find_by(email: user_email).id
        Employee.create(company_id: self.company.id, user_id: user_id, type: "Employee")
    end

    def unemploy(employee)
        employee.destroy
    end
end

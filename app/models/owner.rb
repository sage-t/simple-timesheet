class Owner < Manager
    def add_employee_form
        "render 'add_employee', company: @company"
    end

    def delete_company_link
        "link_to 'Delete', company, method: :delete, data: { confirm: 'Are you sure?' }"
    end
end

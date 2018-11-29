class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  helper_method :curr_emp

  def curr_emp
    if session[:user_id]
      # Automatically sets class to Employee, Manager, or Owner (each provides different functionallity)
      if @company == nil && cookies[:curr_company] != nil
        @company = Company.find(cookies[:curr_company].to_i)
      end
      @curr_emp ||= Employee.find_by(user_id: current_user.id, company_id: @company.id)
    else
      @curr_emp = nil
    end
  end

  # GET /punch
  def punch
    curr_emp.punch
    
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  # POST /companies/employ
  # POST /companies/employ.json
  def employ
    @company = Company.find(params[:company])

    curr_emp.employ(params[:user][:address])

    respond_to do |format|
      format.html { redirect_to @company, notice: 'Employee was successfully added' }
    end
  end

  # GET /unemploy
  def unemploy
    @company = Company.find(params[:company_id])
    employee = Employee.find(params[:employee_id])
    
    curr_emp.unemploy(employee)

    respond_to do |format|
      format.html { redirect_to @company, notice: 'Employee was successfully unemployed' }
    end
  end

  # GET /promote
  def promote
    @company = Company.find(params[:company_id])
    employee = Employee.find(params[:employee_id])
    
    curr_emp.promote(employee)

    respond_to do |format|
      format.html { redirect_to @company, notice: 'Employee was successfully promoted' }
    end
  end

  # GET /demote
  def demote
    @company = Company.find(params[:company_id])
    manager = Manager.find(params[:employee_id])
    
    curr_emp.demote(manager)

    respond_to do |format|
      format.html { redirect_to @company, notice: 'Manager was successfully demoted' }
    end
  end

  # GET /companies/timesheet
  def timesheet
  end

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    require 'company_builder'
    
    company_builder = CompanyBuilder.new
    company_builder.set_name(company_params[:name])
    company_builder.set_owner(session[:user_id])
    company_builder.set_pay_period_start(params)
    company_builder.set_pay_period_end(params)

    respond_to do |format|

      if company_builder.save
        @company = company_builder.company()
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: company_builder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name)
    end
end

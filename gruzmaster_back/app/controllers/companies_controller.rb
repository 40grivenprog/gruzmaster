class CompaniesController < ApplicationController
  before_action :find_company, only: %i[destroy]
  def index
    @companies = Company.all
    
    render json: @companies
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      render json: { message: "OK" }
    else
      render json: { messages: @company.errors.full_messages }, status:  500
    end
  end

  def destroy
    @company.destroy

    render json: Company.all
  end

  private

  def find_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:company_name, :company_description)
  end
end

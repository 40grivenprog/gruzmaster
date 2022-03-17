class CompaniesController < ApplicationController
  before_action :find_company, only: %i[destroy]
  def index
    @companies = Company.all
    
    render json: @companies
  end

  def destroy
    @company.destroy

    render json: Company.all
  end

  private

  def find_company
    @company = Company.find(params[:id])
  end
end

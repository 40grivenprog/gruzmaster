class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    
    render json: @companies
  end
end

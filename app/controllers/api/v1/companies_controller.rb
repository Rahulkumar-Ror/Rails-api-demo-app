class Api::V1::CompaniesController < ApiController
  load_and_authorize_resource
  before_action :set_company, only: [:show, :update, :destroy]

  def index
    @companies = Company.accessible_by(current_ability)
    # @companies = current_user.companies
    render json: @companies, status: 200
  end

  def show
    if @company
      render json: @company, status: :ok 
    else 
      render json: { error: "Couldn't find article" }
    end
  end

  def create
    @company = Company.new(company_params)
    # @company = current_user.companies.new(company_params)
    if @company.save
      render json: @company, status: 201
    else
      render json: { data: @company.errors.full_messages, status: "failed" }, status: 300
    end
  end

  def update
    if @company.update(company_params)
      render json: @company, status: 200
    else
      render json: { data: @company.errors.full_messages, status: "failed" }, status: 400
    end  
  end

  def destroy 
    if @company.destroy
      render json: { data: 'Company deleted successfully', status: 'sucess' }, status: 200
    else
      render json: { error: "Couldn't find company with id #{params[:id]}" }, status: 400
    end
  end

  private

  def set_company
    # @company = Company.find(params[:id])
    @company = current_user.companies.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    render json: error.message, status: :unauthorized
  end

  def company_params
    params.require(:company).permit(:name, :address, :established_year, :user_id)
  end
end

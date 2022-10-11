class Api::V1::CompaniesController < ApiController
  load_and_authorize_resource
  before_action :set_company, only: [:update, :destroy]

  def index
    @companies = current_user.companies
    if @companies.present?
      render json: @companies, status: 200
    else
      render json: { error: "NO companies are registered" }, status: 404
    end
  end
  
  def show
    @company = current_user.companies.find(params[:id])
    render json: @company, status: 200 #For success 
  end
  
  def create
    @company = Company.new(company_params)
    if @company.save
      render json: @company, status: 201 #for successfully created
    else
      render json: { error: 'You missed something while filling the form.' }, status: 422
    end
  end

  def search
    @parameter = params[:name]
    @company = Company.where("lower(name) LIKE :name", name: "%#{@parameter}%")
    if @company != [] 
      render json: @company
    else
      # binding.pry
      render json: "Record with name #{params[:name]} been not found!", status: 404
    end   
	end

  def update
    @company.update(company_params)
    render json: @company, status: 200
  end

  def destroy 
    @company.destroy
    render json: { data: 'Company deleted successfully' }, status: 200
  end

  private

  def set_company
    @company = current_user.companies.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address, :established_year, :user_id)
  end
end

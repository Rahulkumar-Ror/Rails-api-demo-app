class ApplicationController < ActionController::API
  # rescue_from CanCan::AccessDenied do |exception|
  #   render json: { warning: exception, status: 'authorization_failed' }, status: 401 #For authorization failed error
  # end
  # rescue_from ActiveRecord::RecordNotFound, :with => :render_404  
  # def render_404   
  #   render json: { error: "No record exists with given ID = #{params[:id]}" }, status: 404
  # end
  
 
  rescue_from StandardError do |err|
    if err.message.include?('Error occurred while parsing request parameters')
    render json: { error: "Please provide required information properly to create a company" },status: 400
    elsif err.message.include?("Couldn't find")
    render json: { error: "No record exists with given ID = #{params[:id]}" }, status: 404
    else err.message.include?("You are not authorized to access this page.")
      render json: { error: "You are not authorized to access this page." }, status: 401 #For authorization failed error
    end
  end
end

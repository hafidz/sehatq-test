class Api::V1::SessionsController < ApplicationController
  before_action :validate_token

  def create
    user = User.find_by(email: params[:session][:email])
    if user.present?
      if user.valid_password? params[:session][:password]
      	data = {id: user.id, full_name: user.full_name, auth_token: user.auth_token, email: user.email}
        render :json => {meta:{code: 200, messages: "success"}, data: data} 	
      else
        render :json => {meta:{code: 200, messages: "Invalid email or password"}, data: {}} 	
      end
    else
      render :json => {meta:{code: 400, messages: "User Not Found"}, data: {}} 	
    end
  end
end

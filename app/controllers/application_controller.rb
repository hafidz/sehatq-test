class ApplicationController < ActionController::Base
 def validate_token
    # token = ApiKey.where(:client_key => request.headers["HTTP_CLIENTKEY"])
    # if token.blank?
    #   msg = 'Invalid Cient Key'
    #   render :json => {meta:{error_code: 402, messages: msg}, data: {}}
    # else
    #   @token = token.first
      return true
    # end
  end

  def authenticate_user

    if Rails.env.development?
      @user = User.find_by(auth_token: params[:auth_token])
      if @user.blank?
        render :json => {meta:{error_code: 404, messages: "Forbidden Access."}, data: {}}
      end
    end
  end
end

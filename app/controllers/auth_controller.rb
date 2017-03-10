class AuthController < ApplicationController
  skip_before_action :authenticate_request
  before_action :find_user_via_email, only: :log_in

  def index
    render json: Sessions::Builder.new(current_session).profile
  end
  def sign_up
    session = Auth::Processor.new(obj_params).sign_up
    if session
      render json: session
    end
  end
  def log_in
    session = Auth::Processor.new(@user).log_in(obj_params[:password])
    if session
      render json: session
    else
      render json: {error: "Invalid Email and/or Password"}, status: :unauthorized
    end
  end

  private
  def obj_params
    params.require(:user).permit(
      :email,
      :password
    )
  end

  def find_user_via_email
    @user = User.find_by_email(obj_params[:email])
  end
end

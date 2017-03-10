class AuthController < ApplicationController
  def sign_up
    session = Auth::Processor.new(obj_params).sign_up
    if session
      render json: session
    end
  end


  private
  def obj_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end

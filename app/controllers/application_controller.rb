class ApplicationController < ActionController::Base
  # before_action :authenticate_request, except: :index

  def index
    render json: {message: "hello"}
  end
end

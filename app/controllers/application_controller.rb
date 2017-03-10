class ApplicationController < ActionController::Base
  def index
    render json: {message: "hello"}
  end
end

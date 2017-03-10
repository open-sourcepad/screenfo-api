class ApplicationController < ActionController::Base
  include Authenticator
  include CommonResponse
  before_action :authenticate_request, except: :index

  def index
    render json: {message: "hello"}
  end
end

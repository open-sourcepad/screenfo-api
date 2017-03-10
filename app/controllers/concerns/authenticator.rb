module Authenticator
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= Sessions::Processor.new(request_details).find_by_valid_token
  end

  def request_details
    @request_details ||=
      {
        access_token:  request.headers['AccessToken'] || params[:access_token],
        user_id: request.headers['UserId'] || params[:user_id]
      }
  end


end
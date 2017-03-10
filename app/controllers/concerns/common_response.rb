module CommonResponse
  extend ActiveSupport::Concern

  included do
    class ExpiredSessionError < StandardError; end
    rescue_from ExpiredSessionError do
      render json: { error: 'Your session has expired' }, status: :unauthorized
    end
  end
  def render_success
    render json: { success: true }
  end
end

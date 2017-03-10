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

  def render_success_with_object obj
    render json: { success: true, object_class: obj.class.to_s, data: obj}
  end

  def render_errors obj
    render json: { success: false, object_class: obj.class.to_s, errors: obj.errors.full_messages.join(". ")}
  end

end

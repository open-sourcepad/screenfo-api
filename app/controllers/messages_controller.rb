class MessagesController < ApplicationController

  before_action :find_message, only: [:broadcasted]

  def create
    @message = Message.create(message_params.merge(user_id: current_user.id))
    if @message.errors.any?
      render_errors @message
    else
      render_success_with_object @message
    end
  end

  def index
    message = Message.order("created_at DESC").first
    if message.present?
      render json: {message: "#{message.user.email} -  #{message.content}"}
    else
      render json: {}
    end
  end

  def broadcasted
    @message.broadcasted!
    render_success_with_object @message
  end

  private

  def message_params
    params.require(:message).permit(
      :content
    )
  end

  def find_message
    @message = Message.find(params[:message_id])
  end

end

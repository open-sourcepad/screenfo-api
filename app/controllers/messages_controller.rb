class MessagesController < ApplicationController

  def create
    @message = Message.create(message_params.merge(user_id: current_user.id))
    if @message.errors.any?
      render_errors @message
    else
      render_success_with_object @message
    end
  end

  private

  def message_params
    params.require(:message).permit(
      :content
    )
  end
end

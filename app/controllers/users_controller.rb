class UsersController < ApplicationController

  def messages
    @messages = current_user.messages.latest
    render_success_with_object @messages
  end

end

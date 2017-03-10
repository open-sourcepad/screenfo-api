module Auth
  class Processor < Base
    def sign_up
      @user = User.create(@user)
      if @user.errors.empty?
        create_session
      else
        {errors: @user.errors.full_messages.join(". ")}
      end
    end

    def log_in password
      if @user.valid_password?(password)
        create_session
      else
        nil
      end
    end

    def find_by_valid_token
      session = Session.where(access_token: @user[:access_token], user_id: @user[:user_id]).first
      return nil unless session.present? && session.user.present?
      session.user
    end

    def create_session
      session = Sessions::Processor.new(@user).create
      Sessions::Builder.new(session).show_details
    end

  end
end

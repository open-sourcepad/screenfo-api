module Auth
  class Processor < Base
    def sign_up
      @user = User.create(@user)
      create_session
    end

    def log_in password
      if @user.valid_password?(password)
        create_session
      else
        nil
      end
    end

    def create_session
      session = Sessions::Processor.new(@user).create
      Sessions::Builder.new(session).show_details
    end

  end
end

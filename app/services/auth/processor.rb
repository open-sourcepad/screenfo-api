module Auth
  class Processor < Base
    def sign_up
      @user = User.create(@user)
      session = Sessions::Processor.new(@user).create
      Sessions::Builder.new(session).show_details
    end



  end
end

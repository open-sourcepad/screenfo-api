module Sessions
  class Builder
    def initialize session
      @session = session
    end

    def show_details
      {
        user_id: @session.user.id,
        email: @session.user.email,
        access_token: @session.access_token
      }
    end

    def profile
      {
        email: @session.user.email,
        n24_integrated: @session.user.n24_access_token.present?
      }
    end
  end
end

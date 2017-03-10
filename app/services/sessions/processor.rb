module Sessions
  class Processor
    def initialize user
      @user = user
    end

    def create
      session = Session.create(user_id: @user.id, access_token: generate_access_token)
      session
    end

    def find_by_valid_token
      session = Session.where(access_token: @user[:access_token]).first
      return nil unless session.present? && session.user.present?
      session
    end

    private
    def generate_access_token
      loop do
        token = Devise.friendly_token
        break token unless Session.where(access_token: token).first
      end
    end
  end
end

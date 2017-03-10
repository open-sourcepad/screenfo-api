module ThirdPartyIntegration
  class Processor
    N24_LOGIN = "https://next24.io/auth/local"
    def initialize params, user
      @params = params
      @user = user
    end

    def integrate
      if @params[:third_party] == "n24"
        integrate_n24
      end
    end


    private
    def integrate_n24
      response = HttpService::Base.new(N24_LOGIN).post(@params.reject{|x| x == :third_party})
      if response["status"] == "200" || response["status"] == 200
        @user.update_attributes(n24_access_token: response["body"]["token"])
      end
    end
  end
end

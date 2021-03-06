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
      params = {"email"=> @params["username"], "password"=> @params["password"]}
      response = HttpService::Base.new(N24_LOGIN).post(params)
      if response["status"] == "200" || response["status"] == 200
        puts response["body"]["token"]
        @user.update_attributes(n24_access_token: response["body"]["token"])
      end
    end
  end
end

module HttpService
  class Base
    def initialize url, token=nil
      @url = URI.parse(url)
      @token = token
      prepare_http_object
    end


    def get
      get = prepare_get_object
      process_response(send_request(get))
    end

    def post body={}
      post = prepare_post_object(body)
      process_response(send_request(post))
    end

    def send_request request_object
      @http.request(request_object)
    end

    private
    def prepare_http_object
      @http = Net::HTTP.new(@url.host, @url.port)
      @http.use_ssl = true
    end

    def prepare_get_object
      get = Net::HTTP::Get.new(@url.request_uri)
      get["Authorization"] = @token if @token.present?
      get
    end

    def prepare_post_object body
      post = Net::HTTP::Post.new(@url.request_uri)
      post["Authorization"] = @token if @token.present?
      post["ContentType"] = "application/json;charset=UTF-8"
      post.set_form_data(body)
      post
    end

    def process_response response_object
      response =   {}
      response["status"] =  response_object.code
      response["body"] = JSON.parse(response_object.body)
      response
    end
  end
end

module N24
  class Processor
    PROFILE_LINK = "https://next24.io/api/users/me"
    PROJECT_LINK = "https://next24.io/api/projects"
    def initialize user
      @user = user
      @token = "Bearer #{@user.n24_access_token}"
    end

    def current_tasks
      get_n24_id
      list_project_tasks
    end

    private
    def get_n24_id
      user_details = HttpService::Base.new(PROFILE_LINK, @token).get["body"]
      @n24_user_id = user_details["_id"]
    end

    def list_project_tasks
      projects = HttpService::Base.new(PROJECT_LINK, @token).get["body"]
      collection = []
      projects.each do |project|
        project_name = project["name"]
        collection = collection | get_user_tasks(project["scrums"], project_name)
      end
      collection
    end


    def get_user_tasks scrum, project_name
      collection = []
      scrum_collection = scrum.sort{|a,b| b["created"] <=> a["created"]}
      if scrum_collection.first["notes"].empty? && scrum_collection.second && !scrum_collection.second["notes"].try("empty?")
        scrum_collection.second["notes"].each do |row|
          if row["user"] == @n24_user_id && row["state"] == "pending"
            collection.push("#{project_name}(#{Date.parse(row['created']).strftime('%b %d, %Y')}) - #{row['name']}")
          end
        end
      elsif !scrum_collection.first["notes"].empty?
        scrum_collection.first["notes"].each do |row|
          if row["user"] == @n24_user_id && row["state"] == "pending"
            collection.push("#{project_name}(#{Date.parse(row['created']).strftime('%b %d, %Y')}) - #{row['name']}")
          end
        end
      end
      collection
    end
  end
end

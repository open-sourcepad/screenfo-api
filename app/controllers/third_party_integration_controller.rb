class ThirdPartyIntegrationController < ApplicationController
  def create
    if ThirdPartyIntegration::Processor.new(obj_params, current_user).integrate
      render_success
    end
  end

  def get_n24_tasks
    render json: N24::Processor.new(current_user).current_tasks
  end

  private
  def obj_params
    params.require(:third_party).permit(
      :username,
      :password,
      :third_party
    )
  end
end

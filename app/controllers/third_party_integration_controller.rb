class ThirdPartyIntegrationController < ApplicationController
  def create
    if ThirdPartyIntegration::Processor.new(obj_params, current_user).integrate
      render_success
    end
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

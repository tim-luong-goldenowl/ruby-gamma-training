class ApplicationController < ActionController::Base
  def create_user
    Users::CreateUserService.call(user_params)
  end

  rescue ActiveRecord::RecordInvalid
    render json: {success: false}
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :name,
      :age
    )
  end
end

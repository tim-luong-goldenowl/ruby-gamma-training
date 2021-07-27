class ApplicationController < ActionController::Base
  def create_user
    user = CreateUserService(user_params, current_user)
    if user.present?
      SendConfirmationEmailService(user)
      render json: {success: true}
    else
      render json: {success: false}
    end
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

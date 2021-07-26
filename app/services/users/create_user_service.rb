class Users::CreateUserService < ApplicationService
  def initialize(user_params)
    @user_params = user_params
  end

  def call
    ActiveRecord::Base.transaction do
      exsiting_deleted_user = User.only_deleted.find_by_email(@user_params[:email])
      exsiting_deleted_user.really_destroy! if exsiting_deleted_user.present?

      user = User.new(@user_params)

      user.set_default_password
      user.set_random_username
      user.created_by = current_user
      user.add_role(:user)

      ServiceResponse.new(user).success?
    end
  end
end

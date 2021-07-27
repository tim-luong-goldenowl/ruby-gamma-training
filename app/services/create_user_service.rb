class CreateUserService < ApplicationService
  def initialize(user_params, current_user)
    @user_params = user_params
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      find_exsiting_deleted_user
      destroy_exsiting_deleted_user(exsiting_deleted_user)
      user = create_new_user

      return user if ServiceResponse.new(user).success?
      return false
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def find_exsiting_deleted_user
    User.only_deleted.find_by_email(@user_params[:email])
  end

  def destroy_exsiting_deleted_user(exsiting_deleted_user)
    exsiting_deleted_user.really_destroy! if exsiting_deleted_user.present?
  end

  def create_new_user
    user = User.new(@user_params)

    user.set_default_password
    user.set_random_username
    user.created_by = @current_user
    user.add_role(:user)
    user
  end
end

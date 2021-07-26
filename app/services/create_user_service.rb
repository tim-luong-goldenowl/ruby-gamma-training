class CreateUserService < ApplicationService
  def initialize(user_params, current_user)
    @user_params = user_params
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      exsiting_deleted_user

      prepare_user

      @user.save!

      ServiceResponse.new(payload: true)
    end

  rescue ActiveRecord::RecordInvalid => e
    ServiceResponse.new(errors: e.record.errors)
  end

  private

  def exsiting_deleted_user
    user = User.only_deleted.find_by_email(@user_params[:email])
    user.really_destroy! if user.present?
  end

  def prepare_user
    @user = User.new(@user_params)

    @user.set_default_password
    @user.set_random_username
    @user.created_by = @current_user
    @user.add_role(:user)
  end
end

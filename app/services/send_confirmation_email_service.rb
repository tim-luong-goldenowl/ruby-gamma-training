class SendConfirmationEmailService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    Mailer.send_confirmation_email(@user)
  end
end
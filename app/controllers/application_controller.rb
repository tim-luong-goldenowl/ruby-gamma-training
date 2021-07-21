class ApplicationController < ActionController::Base
  def index
    render json: {users: User.all}
  end
end

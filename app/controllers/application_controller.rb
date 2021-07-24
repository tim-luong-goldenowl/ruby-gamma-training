class ApplicationController < ActionController::Base
  def index
    # DemoWorker.perform_async
    render json: {users: User.all}
  end
end

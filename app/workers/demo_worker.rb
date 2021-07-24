class DemoWorker
  include Sidekiq::Worker

  def perform
    User.destroy_all
    User.create(name: DateTime.now.to_s, age: 99)
  end
end

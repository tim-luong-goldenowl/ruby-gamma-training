class DemoWorker
  include Sidekiq::Worker

  def perform(name, count)
    User.destroy_all
    User.create(name: DateTime.now.to_s, age: 99)
  end
end

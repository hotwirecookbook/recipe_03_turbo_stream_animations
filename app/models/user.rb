class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers("online_users")
    where(id: ids)
  end
end

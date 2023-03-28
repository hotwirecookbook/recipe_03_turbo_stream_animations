class OnlineChannel < Turbo::StreamsChannel
  def subscribed
    super
    ActionCable.server.pubsub.redis_connection_for_subscriptions.sadd(
      "online_users",
      current_user.id
    )

    Turbo::StreamsChannel.broadcast_append_to "online_users",
      target: "online_users",
      partial: "users/card", locals: { user: current_user }
  end

  def unsubscribed
    super
    ActionCable.server.pubsub.redis_connection_for_subscriptions.srem(
      "online_users",
      current_user.id
    )
    Turbo::StreamsChannel.broadcast_remove_to "online_users",
    target: "user_#{current_user.id}"
  end
end
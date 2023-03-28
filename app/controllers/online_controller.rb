class OnlineController < ApplicationController
  def index
    @online_users = User.online
  end
end

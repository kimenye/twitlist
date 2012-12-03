class HomeController < ApplicationController
  def index
    #@users = User.all
  end

  def play
    if !session[:credentials].nil?
      uid = current_user.authentications.first.uid
      #@followers = @client.follower_ids(uid.to_i)

      user = twitter_client.user(uid.to_i)
      @followers_count = user[:followers_count]
    end
  end
end

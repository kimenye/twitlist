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

      if session[:friends].nil?
        @friends = get_friends(uid.to_i)
        session[:friends] = @friends
      end
    end
  end

  def get_friends(uid)
    friend_ids = twitter_client.friend_ids(uid).ids

    i = friend_ids.length / 100
    i += 1 if (friend_ids.length % 100 > 0)

    friends = []
    i.times do |i|
      start = i * 100
      current_batch = friend_ids.slice( i * 100, 100 )
      for user in twitter_client.users(current_batch) do
        friends << { label: user.name, value: user.screen_name }
      end
    end
    friends
  end
end

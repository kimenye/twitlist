class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def twitter_client
    @client ||= Twitter::Client.new(
        :oauth_token => session[:credentials][:token],
        :oauth_token_secret => session[:credentials][:secret]
    ) if session[:credentials]
  end
end

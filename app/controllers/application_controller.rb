class ApplicationController < ActionController::Base
  include SessionsHelper
  include DevicesHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def count(user)
    @count_likes = user.likes.count
  end
  
  def counts(device)
    @count_liked = device.liked.count
  end
end

module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def correct_user?
    unless @current_user == User.find(params[:id])
      flash[:danger] = "\u4E0D\u6B63\u306A\u30A2\u30AF\u30BB\u30B9\u3067\u3059"
      redirect_to root_url
    end
  end

  def review_user?
    @review = Review.find(params[:id])
    unless @current_user.id == @review.user_id
      redirect_to login_url
    end
  end
end

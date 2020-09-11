module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  def correct_user?
    unless @current_user == User.find(params[:id])
      flash[:danger] = '不正なアクセスです'
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

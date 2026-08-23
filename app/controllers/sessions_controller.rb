class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "\u30ED\u30B0\u30A4\u30F3\u306B\u6210\u529F\u3057\u307E\u3057\u305F\u3002"
      redirect_to @user
    else
      flash.now[:danger] = "\u30ED\u30B0\u30A4\u30F3\u306B\u5931\u6557\u3057\u307E\u3057\u305F\u3002"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "\u30ED\u30B0\u30A2\u30A6\u30C8\u3057\u307E\u3057\u305F\u3002"
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      true
    else
      false
    end
  end
end

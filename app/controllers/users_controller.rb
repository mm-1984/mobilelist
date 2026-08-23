class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [ :edit, :update, :destroy ]
  before_action :user_find, only: [ :show, :edit, :update, :destroy, :likes ]
  before_action :correct_user?, only: [ :edit, :update, :destroy ]

  def show
    @devices = @user.likes
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "\u30E6\u30FC\u30B6\u3092\u767B\u9332\u3057\u307E\u3057\u305F\u3002"
      redirect_to @user
    else
      flash.now[:danger] = "\u30E6\u30FC\u30B6\u306E\u767B\u9332\u306B\u5931\u6557\u3057\u307E\u3057\u305F\u3002"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "\u30E6\u30FC\u30B6\u30FC\u60C5\u5831\u306F\u6B63\u5E38\u306B\u66F4\u65B0\u3055\u308C\u307E\u3057\u305F"
      redirect_to @user
    else
      flash.now[:danger] = "\u30E6\u30FC\u30B6\u30FC\u60C5\u5831\u306F\u66F4\u65B0\u3055\u308C\u307E\u305B\u3093\u3067\u3057\u305F"
      render :edit
    end
  end

  def destroy
    @user.destroy

    flash[:success] = "\u30E6\u30FC\u30B6\u30FC\u767B\u9332\u3092\u524A\u9664\u3057\u307E\u3057\u305F"
    redirect_to root_url
  end

  def likes
    @devices = @user.likes
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def user_find
    @user = User.find(params[:id])
  end
end

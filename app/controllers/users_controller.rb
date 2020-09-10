class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]
  before_action :user_find, only: [:show, :edit, :update, :destroy, :likes]
  before_action :correct_user?, only: [:edit, :update, :destroy]
  
  def show
    @devices = @user.likes
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報は正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @user.destroy
    
    flash[:success] = 'ユーザー登録を削除しました'
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
  
  def correct_user
    @user = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end

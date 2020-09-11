class DevicesController < ApplicationController
  before_action :device_find, only: [:show, :edit, :update, :destroy]
  before_action :admin_user_only, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)
    
    if @device.save
      flash[:success] = '新規端末を登録しました'
      redirect_to root_url
    else
      flash[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def show
    counts(@device)
    @reviews = Review.where(device_id: @device.id)
  end

  def edit
  end

  def update
    if @device.update(device_params)
      flash[:success] = '端末情報を編集しました'
      redirect_to @device
    else
      flash[:danger] = '端末情報を編集できませんでした'
      render :edit
    end
  end

  def destroy
    @device.destroy
    flash[:success] = '端末情報を削除しました'
    redirect_to root_url
  end
  
  private
  
  def device_params
    params.require(:device).permit(:name, :content, :image, :maker, :on_sale, :size)
  end
  
  def device_find
    @device = Device.find(params[:id])
  end
  
  def admin_user_only
    unless admin_user?
      redirect_to login_url
    end
  end
end

class DevicesController < ApplicationController
  
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
    @device = Device.find(params[:id])
  end

  def edit
    @device = Device.find(params[:id])
  end

  def update
    @device = Device.find(params[:id])
    
    if @device.update(device_params)
      flash[:success] = '端末情報を編集しました'
      redirect_to @device
    else
      flash[:danger] = '編集できませんでした'
      render :edit
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    flash[:success] = '端末情報を削除しました'
    redirect_to root_url
  end
  
  private
  
  def device_params
    params.require(:device).permit(:name, :content, :image)
  end
  
  
end

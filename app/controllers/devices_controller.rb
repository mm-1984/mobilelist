class DevicesController < ApplicationController
  before_action :device_find, only: [ :show, :edit, :update, :destroy ]
  before_action :admin_user_only, only: [ :new, :create, :edit, :update, :destroy ]

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)

    if @device.save
      flash[:success] = "\u65B0\u898F\u7AEF\u672B\u3092\u767B\u9332\u3057\u307E\u3057\u305F"
      redirect_to root_url
    else
      flash[:danger] = "\u767B\u9332\u306B\u5931\u6557\u3057\u307E\u3057\u305F"
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
      flash[:success] = "\u7AEF\u672B\u60C5\u5831\u3092\u7DE8\u96C6\u3057\u307E\u3057\u305F"
      redirect_to @device
    else
      flash[:danger] = "\u7AEF\u672B\u60C5\u5831\u3092\u7DE8\u96C6\u3067\u304D\u307E\u305B\u3093\u3067\u3057\u305F"
      render :edit
    end
  end

  def destroy
    @device.destroy
    flash[:success] = "\u7AEF\u672B\u60C5\u5831\u3092\u524A\u9664\u3057\u307E\u3057\u305F"
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

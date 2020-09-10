class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    device = Device.find(params[:device_id])
    current_user.favorite(device)
    flash[:success] = 'いいね！しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    device = Device.find(params[:device_id])
    current_user.unfavorite(device)
    flash[:success] = 'いいね！を取り消しました。'
    redirect_back(fallback_location: root_path)
  end
end

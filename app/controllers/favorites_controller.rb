class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    device = Device.find(params[:device_id])
    current_user.favorite(device)
    flash[:success] = "\u3044\u3044\u306D\uFF01\u3057\u307E\u3057\u305F\u3002"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    device = Device.find(params[:device_id])
    current_user.unfavorite(device)
    flash[:success] = "\u3044\u3044\u306D\uFF01\u3092\u53D6\u308A\u6D88\u3057\u307E\u3057\u305F\u3002"
    redirect_back(fallback_location: root_path)
  end
end

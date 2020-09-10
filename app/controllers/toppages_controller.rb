class ToppagesController < ApplicationController
  def index
    @devices = Device.all.order(id: :desc).page(params[:page]).per(5)
    @ranking = Device.find(Favorite.group(:device_id).order('count(device_id) desc').limit(3).pluck(:device_id))
  end
  
end
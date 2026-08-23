class ToppagesController < ApplicationController
  def index
    @devices = Device.all.order(id: :desc)
    @ranking = Device.find(Favorite.group(:device_id).order(Arel.sql("count(device_id) desc")).limit(3).pluck(:device_id))
  end
end

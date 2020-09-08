class ToppagesController < ApplicationController
  def index
    @devices = Device.all
  end
  
end
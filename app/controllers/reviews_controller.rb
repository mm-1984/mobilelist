class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @review = Review.new
  end

  def create
    # Review.find_by(device_id: params[:review][:device_id])
    @review = current_user.reviews.build(review_params)
    if @review_device_id.save
      flash[:success] = 'レビューを投稿しました'
      redirect_to root_url
    else
      @reviews = current_user.reviews.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'reviews/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :device_id)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
  
  
end

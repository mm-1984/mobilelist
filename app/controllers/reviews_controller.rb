class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @review = Review.new
    @device = Device.find(params[:id])
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました'
      redirect_to root_url
    else
      @reviews = current_user.reviews.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'reviews/new'
    end
  end

  def edit
    @review = Review.find(params[:id])
    @device_id = @review.device_id
  end
  
  def update
    @review = Review.find(params[:id])
    
    if @review.update(review_params)
      flash[:success] = 'レビューを更新しました'
      redirect_to device_path(@review.device_id)
    else
      flash.now[:danger] = '口コミは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:success] = '口コミを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :device_id)
  end
  
end

class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :review_find, only: [:edit, :update, :destroy]
  before_action :review_user?, only: [:edit, :update, :destroy]
  
  def new
    @review = Review.new
    @device = Device.find(params[:id])
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました'
      redirect_to device_path(@review.device_id)
    else
      @reviews = current_user.reviews.order(id: :desc).page(params[:page])
      flash[:danger] = '投稿に失敗しました。'
      redirect_to "/devices/#{@review.device_id}/review", flash: { error: @review.errors.full_messages }
    end
  end

  def edit
    @device_id = @review.device_id
  end
  
  def update
    if @review.update(review_params)
      flash[:success] = 'レビューを更新しました'
      redirect_to device_path(@review.device_id)
    else
      flash[:danger] = '口コミは更新されませんでした'
      redirect_to "/reviews/#{@review.id}/edit", flash: { error: @review.errors.full_messages }
    end
  end
  
  def destroy
    @review.destroy
    flash[:success] = '口コミを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :device_id)
  end
  
  def review_find
    @review = Review.find(params[:id])
  end
end

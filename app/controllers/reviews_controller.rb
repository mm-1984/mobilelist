class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :review_find, only: [ :edit, :update, :destroy ]
  before_action :review_user?, only: [ :edit, :update, :destroy ]

  def new
    @review = Review.new
    @device = Device.find(params[:id])
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "\u30EC\u30D3\u30E5\u30FC\u3092\u6295\u7A3F\u3057\u307E\u3057\u305F"
      redirect_to device_path(@review.device_id)
    else
      @reviews = current_user.reviews.order(id: :desc).page(params[:page])
      flash[:danger] = "\u6295\u7A3F\u306B\u5931\u6557\u3057\u307E\u3057\u305F\u3002"
      redirect_to "/devices/#{@review.device_id}/review", flash: { error: @review.errors.full_messages }
    end
  end

  def edit
    @device_id = @review.device_id
  end

  def update
    if @review.update(review_params)
      flash[:success] = "\u30EC\u30D3\u30E5\u30FC\u3092\u66F4\u65B0\u3057\u307E\u3057\u305F"
      redirect_to device_path(@review.device_id)
    else
      flash[:danger] = "\u53E3\u30B3\u30DF\u306F\u66F4\u65B0\u3055\u308C\u307E\u305B\u3093\u3067\u3057\u305F"
      redirect_to "/reviews/#{@review.id}/edit", flash: { error: @review.errors.full_messages }
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "\u53E3\u30B3\u30DF\u3092\u524A\u9664\u3057\u307E\u3057\u305F\u3002"
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

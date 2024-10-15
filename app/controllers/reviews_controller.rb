class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = @movie.reviews.includes(:user)
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      flash[:notice] = 'Comment created successfully'
      redirect_to movie_path(@movie)
    else
      render 'movies/show'
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      flash[:notice] = 'Comment updated successfully'
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = 'Comment deleted successfully'
    redirect_to movie_reviews_path(@movie)
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def validate_review_owner
    unless @review.user == current_user
      flash[:notice] = 'the review not belongs to you'
      redirect_to movie_reviews_path(@movie)
    end
  end
end
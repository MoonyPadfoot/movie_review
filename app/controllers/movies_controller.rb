class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @top_movies = Movie.top_3_by_rating
    @movies = Movie.all
                   .includes(:genres)
                   .order_by_rating
                   .filter_by_title(params[:title])
                   .filter_by_status(params[:status])
                   .filter_by_genre(params[:genre_ids])
                   .page(params[:page]).per(3)
  end

  def show
    @review = @movie.reviews.new
    @reviews = @movie.reviews.order(rating: :desc)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      flash[:notice] = 'Movie created successfully!'
      redirect_to movies_path
    else
      flash.now[:alert] = 'Movie creation failed'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      flash[:notice] = 'Movie updated successfully!'
      redirect_to movies_path
    else
      flash.now[:alert] = 'Movie update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    flash[:notice] = 'Movie deleted successfully'
    redirect_to movies_path(page: params[:page])
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:slug]) || Movie.find(params[:id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :blurb, :date_released, :country_of_origin, :showing_start, :showing_end, :slug, genre_ids: [])
  end
end

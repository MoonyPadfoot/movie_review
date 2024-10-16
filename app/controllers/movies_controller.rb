class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @top_movies = Movie.top_3_by_rating
    @movies = Movie.includes(:genres)
                   .order_by_rating
                   .filter_by_title(params[:title])
                   .filter_by_status(params[:status])
                   .filter_by_genre(params[:genre_ids])
                   .page(params[:page]).per(1)

    @top_movies.select { |movie| movie.id }
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

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:slug])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :blurb, :date_released, :country_of_origin, :showing_start, :showing_end, genre_ids: [])
  end
end

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
                .includes(:genres).page(params[:page]).per(1)
  end

  def show; end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

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
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :blurb, :date_released, :country_of_origin, :showing_start, :showing_end, genre_ids: [])
  end
end

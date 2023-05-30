class GenresController < ApplicationController
  before_action :set_genre, only: %i[show edit]

  def index
    @genres = Genre.all
  end

  def show; end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.add_genre(genre_params[:name])
    if @genre
      redirect_to @genre
    else
      flash.now[:alert] = 'This genre already exists!'
      @genre = Genre.new
      render :new
    end
  end

  def edit; end

  def update
    @genre = Genre.update_genre(genre_params[:name], params[:id])
    if @genre
      redirect_to @genre
    else
      flash.now[:alert] = 'This genre already exists!'
      set_genre
      render :edit
    end
  end

  def destroy
    Genre.delete_genre_id(params[:id])
    redirect_to genres_path
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end

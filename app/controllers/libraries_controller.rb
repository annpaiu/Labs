class LibrariesController < ApplicationController
  before_action :set_library, only: %i[show edit update]

  def index
    @libraries = LibrariesQuery.main_sort(params)
    @sort_by = params[:sort_by]
    @name = params[:name]
  end

  def show
    @books = @library.books
    @reader_cards = @library.reader_cards
  end

  def new
    @library = Library.new
  end

  def create
    # @library = Library.add_library(library_params[:name], library_params[:location], library_params[:year_of_creation])
    @library = Library.new(name: library_params[:name], location: library_params[:location], year_of_creation: library_params[:year_of_creation],street_address: library_params[:street_address], zip_code: library_params[:zip_code], image: library_params[:image])
    if @library.save
      redirect_to @library
    else
      flash.now[:alert] = 'This library already exists!'
      @library = Library.new(name: library_params[:name], location: library_params[:location], year_of_creation: library_params[:year_of_creation], image: library_params[:image])
      render :new
    end
  end

  def edit; end

  def update
    # @library = Library.update_library(library_params[:name], library_params[:location], library_params[:year_of_creation], params[:id])
    if @library.update(name: library_params[:name], location: library_params[:location], year_of_creation: library_params[:year_of_creation], street_address: library_params[:street_address], zip_code: library_params[:zip_code], image: library_params[:image])
      redirect_to @library
    else
      flash.now[:alert] = 'This library already exists!'
      set_library
      render :edit
    end
  end

  def destroy
    Library.delete_library_id(params[:id])
    redirect_to libraries_path
  end

  private

  def set_library
    @library = Library.find(params[:id])
  end

  def library_params
    params.require(:library).permit(:name, :location, :year_of_creation, :street_address, :zip_code, :image)
  end
end

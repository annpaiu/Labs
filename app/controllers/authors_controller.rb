class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit]

  def index
    @authors = Author.all
  end

  def show; end

  def new
    @author = Author.new
  end

  def create
    @author = Author.add_author(author_params[:name], author_params[:birthdate])
    if @author
      redirect_to @author
    else
      flash.now[:alert] = 'This author already exists!'
      @author = Author.new
      render :new
    end
  end

  def edit; end

  def update
    @author = Author.update_author(author_params[:name], author_params[:birthdate], params[:id])
    if @author
      redirect_to @author
    else
      flash.now[:alert] = 'This author already exists!'
      set_author
      render :edit
    end
  end

  def destroy
    Author.delete_author_id(params[:id])
    redirect_to authors_path
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :birthdate)
  end
end

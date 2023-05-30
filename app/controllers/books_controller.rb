class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit]

  def index
    @books = Book.all
  end

  def new
    set_new_book
  end

  def create
    @book = Book.add_book(book_params[:title], book_params[:published_date], book_params[:library_id],
                          book_params[:reader_card_id])
    genre_ids = params[:book][:genre_ids].drop(1)
    author_ids = params[:book][:author_ids].drop(1)
    if @book
      author_ids.each do |author_id|
        Book.add_book_author(@book.id, author_id)
      end
      genre_ids.each do |genre_id|
        Book.add_book_genre(@book.id, genre_id)
      end
      redirect_to @book
    else
      flash.now[:alert] = 'All fields must be filled!'
      set_new_book
      render :new
    end
  end

  def show
    @genres = @book.genres
    @authors = @book.authors
  end

  def edit
    @reader_cards = ReaderCard.all
    @libraries = Library.all
  end

  def update
    @book = Book.update_book(book_params[:title], book_params[:published_date], book_params[:library_id],
                             book_params[:reader_card_id], params[:id])
    if @book
      redirect_to @book
    else
      flash.now[:alert] = 'All fields must be filled!'
      set_book
      @reader_cards = ReaderCard.all
      @libraries = Library.all
      render :edit
    end
  end

  def destroy
    Book.delete_book_id(params[:id])
    redirect_to books_path
  end

  private

  def set_new_book
    @book = Book.new
    @reader_cards = ReaderCard.all
    @libraries = Library.all
    @genres = Genre.all
    @authors = Author.all
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :published_date, :library_id, :reader_card_id, author_ids: [], genre_ids: [])
  end
end

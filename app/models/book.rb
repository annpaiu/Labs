class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :book_genres
  has_many :genres, through: :book_genres
  belongs_to :library
  belongs_to :reader_card
  validates :title, presence: true
  validates :published_date, presence: true
  validates :library, presence: true
  validates :reader_card, presence: true


  def self.add_book(title, published_date, library_id, reader_card_id)
    library = Library.find(library_id)
    reader_card = ReaderCard.find(reader_card_id)
    book = Book.new(title: title, published_date: published_date, library: library, reader_card: reader_card)
    if book.valid?
      book.save
      Book.last
    else
      # Обработка ошибок валидации
      puts book.errors.full_messages
      nil
    end
  end

  def self.update_book (title, published_date, library_id, reader_card_id, id)
    library = Library.find(library_id)
    reader_card = ReaderCard.find(reader_card_id)
    book_id = Book.find(id)
    book = Book.new(title: title, published_date: published_date, library: library, reader_card: reader_card)
    if book.valid?
      book_id.update(title: title, published_date: published_date, library: library, reader_card: reader_card)
      return Book.find(id)
    else
      # Обработка ошибок валидации
      puts book.errors.full_messages
      nil
    end
  end

  def self.delete_book_id (id)
    book_id = Book.find(id)
    book_id.delete
  end

  def self.add_book_author(book_id, author_id)
    book = Book.find(book_id)
    author = Author.find(author_id)
    book.authors << author
  end

  def self.add_book_genre(book_id, genre_id)
    book = Book.find(book_id)
    genre = Genre.find(genre_id)
    book.genres << genre
  end

  # def self.add_books(title, published_date, library_id, reader_card_id, amount, id)
  #   i = 0
  #   while i <= amount do
  #     update_book(title + i.to_s, published_date + i, library_id, reader_card_id, id + i)
  #     i = i + 1
  #   end
  # end

end

class Library < ApplicationRecord
  has_many :books
  has_many :reader_cards
  validates :location, presence: true
  validates :name, presence: true, uniqueness: {  scope: [:location, :year_of_creation]}
  validates :year_of_creation, presence: true
  validates :street_address, presence: true
  validates :zip_code, presence: true
  has_one_attached :image

  def self.add_library(name, location, year_of_creation)
    create_updated = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    library = Library.new(name: name, location: location, year_of_creation: year_of_creation)
    if library.valid?
      connection.execute("INSERT INTO libraries (name, location, created_at, updated_at, year_of_creation) VALUES ('#{name}', '#{location}', '#{create_updated}','#{create_updated}', '#{year_of_creation}')")
      Library.last
    else
      # Обработка ошибок валидации
      puts library.errors.full_messages
      nil
    end
  end

  def self.update_library(name, location, year_of_creation, id)
    updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    library = Library.new(name: name, location: location, year_of_creation: year_of_creation)
    if library.valid?
      connection.execute("UPDATE libraries SET name = '#{name}', location = '#{location}', year_of_creation = '#{year_of_creation}', updated_at = '#{updated_at}' WHERE id = #{id}")
      return Library.find(id)
    else
      # Обработка ошибок валидации
      puts library.errors.full_messages
      nil
    end
  end

  def self.delete_library_id (id)
    connection.execute("DELETE FROM libraries WHERE id = #{id}")
  end

  def self.book_counts
    result = Library.find_by_sql("SELECT * FROM library_book_counts")
    result.each do |row|
      puts "Library #{row.library_name} has #{row.book_count} books"
    end
  end

  # def self.list_libraries
  #     Library.find_by_sql("
  #   SELECT libraries.id, libraries.name, COUNT(DISTINCT books.id) AS books_count, COUNT(DISTINCT genres.id) AS genres_count
  #   FROM libraries
  #   LEFT JOIN books ON books.library_id = libraries.id
  #   LEFT JOIN book_genres ON book_genres.book_id = books.id
  #   LEFT JOIN genres ON genres.id = book_genres.genre_id
  #   GROUP BY libraries.id, libraries.name
  # ")
  # end

end

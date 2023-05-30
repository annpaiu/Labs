class Genre < ApplicationRecord
  has_many :book_genres
  has_many :books, through: :book_genres
  validates :name, presence: true, uniqueness: true

  def self.add_genre(name)
    create_updated = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    genre = Genre.new(name: name)
    if genre.valid?
      connection.execute("INSERT INTO genres (name, created_at, updated_at) VALUES ('#{name}', '#{create_updated}','#{create_updated}')")
      Genre.last
    else
      # Обработка ошибок валидации
      puts genre.errors.full_messages
      nil
    end
  end

  def self.update_genre(name, id)
    updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    genre = Genre.new(name: name)
    if genre.valid?
      connection.execute("UPDATE genres SET name = '#{name}', updated_at = '#{updated_at}' WHERE id = #{id}")
      Genre.find(id)
    else
      # Обработка ошибок валидации
      puts genre.errors.full_messages
      nil
    end

  end

  def self.delete_genre_id (id)
    connection.execute("DELETE FROM genres WHERE id = #{id}")
  end

end


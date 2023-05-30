class Author < ApplicationRecord
  has_many :author_books
  has_many :books, through: :author_books
  validates :name, presence: true, uniqueness: { scope: [:birthdate] }
  validates :birthdate, presence: true

  def self.add_author(name, birthdate)
    create_updated = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    author = Author.new(name: name, birthdate: birthdate)
    if author.valid?
      connection.execute("INSERT INTO authors (name, birthdate, created_at, updated_at) VALUES ('#{name}', '#{birthdate}', '#{create_updated}','#{create_updated}')")
      Author.last
    else
      # Обработка ошибок валидации
      puts author.errors.full_messages
      nil
    end
  end

  def self.update_author(name, birthdate, id)
    updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    author = Author.new(name: name, birthdate: birthdate)
    if author.valid?
      connection.execute("UPDATE authors SET name = '#{name}', birthdate = '#{birthdate}', updated_at = '#{updated_at}' WHERE id = #{id}")
      Author.find(id)
      # author_id = connection.execute("SELECT last_insert_rowid()")[0][0]
      # find(author_id)
    else
      # Обработка ошибок валидации
      puts author.errors.full_messages
      nil
    end
  end

  def self.delete_author_id (id)
    connection.execute("DELETE FROM authors WHERE id = #{id}")
  end

  def self.book_counts
    result = Author.find_by_sql("SELECT * FROM author_book_counts")
    result.each do |row|
      puts "Author #{row.name} has #{row.book_count} books"
    end
  end
end

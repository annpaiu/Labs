class CreateAuthorBookCountsView < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE VIEW author_book_counts AS
        SELECT authors.id, authors.name, COUNT(*) as book_count
        FROM authors
        JOIN author_books ON authors.id = author_books.author_id
        JOIN books ON books.id = author_books.book_id
        GROUP BY authors.id
        ORDER BY authors.name ASC;
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW author_book_counts;
    SQL
  end
end

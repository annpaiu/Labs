class CreateLibraryBookCountsView < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE VIEW library_book_counts AS
        SELECT libraries.id AS library_id, libraries.name AS library_name, libraries.location AS library_location, COUNT(books.id) AS book_count
        FROM libraries
        LEFT JOIN books ON libraries.id = books.library_id
        GROUP BY libraries.id, libraries.name, libraries.location;
    SQL
  end

  def down
    execute 'DROP VIEW IF EXISTS library_book_counts;'
  end
end

class AddYearOfCreationToLibraries < ActiveRecord::Migration[7.0]
  def change
    add_column :libraries, :year_of_creation, :integer
  end
end

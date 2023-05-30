class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.date :published_date

      t.timestamps
    end
  end
end

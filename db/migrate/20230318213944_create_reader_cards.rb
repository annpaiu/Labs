class CreateReaderCards < ActiveRecord::Migration[7.0]
  def change
    create_table :reader_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
  end
end

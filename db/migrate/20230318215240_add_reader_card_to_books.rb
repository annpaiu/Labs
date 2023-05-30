class AddReaderCardToBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :reader_card, null: false, foreign_key: true, default: 1
  end
end

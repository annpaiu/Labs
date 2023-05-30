class ReaderCard < ApplicationRecord
  belongs_to :user
  belongs_to :library
  has_many :books
  validates :library, presence: true
  validates :user, presence: true, uniqueness: { scope: [:library] }

  def self.add_reader_card(user_id, library_id)
    user = User.find(user_id)
    library = Library.find(library_id)
    reader_card = ReaderCard.new(user: user, library: library)
    if reader_card.valid?
      reader_card.save
      ReaderCard.last
    else
      # Обработка ошибок валидации
      puts reader_card.errors.full_messages
      nil
    end
  end

  def self.update_reader_card (user_id, library_id, id)
    library = Library.find(library_id)
    user = User.find(user_id)
    reader_card_id = ReaderCard.find(id)
    reader_card = ReaderCard.new(user: user, library: library)
    if reader_card.valid?
      reader_card_id.update(user: user, library: library)
      return reader_card_id
    else
      # Обработка ошибок валидации
      puts reader_card.errors.full_messages
      nil
    end
  end

  def self.delete_reader_card_id (id)
    reader_card_id = ReaderCard.find(id)
    reader_card_id.delete
  end

  def name_with_library
    "#{id} - #{user.name} (#{library.name})"
  end

end



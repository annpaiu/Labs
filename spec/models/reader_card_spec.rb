require 'rails_helper'

RSpec.describe ReaderCard, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      library = Library.add_library('asfasas', 'asfasasafszz')
      reader_card = ReaderCard.new(user:, library:)
      expect(reader_card).to be_valid
    end
    it 'is not valid without an library' do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      reader_card = ReaderCard.new(user:, library: nil)
      expect(reader_card).not_to be_valid
    end

    it 'is not valid without an user' do
      library = Library.add_library('asfasas', 'asfasasafszz')
      reader_card = ReaderCard.new(user: nil, library:)
      expect(reader_card).not_to be_valid
    end

    it 'is not valid without an user, library' do
      reader_card = ReaderCard.new(user: nil, library: nil)
      expect(reader_card).not_to be_valid
    end

    it 'is not valid with a duplicate user and library' do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      library = Library.add_library('asfasas', 'asfasasafszz')
      ReaderCard.create(user:, library:)
      reader_card = ReaderCard.new(user:, library:)
      expect(reader_card).not_to be_valid
    end
  end

  describe '.add_reader_card' do
    it 'creates a new reader_card' do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      library = Library.add_library('asfasas', 'asfasasafszz')
      expect { ReaderCard.add_reader_card(user.id, library.id) }.to change { ReaderCard.count }.by(1)
    end

    it 'returns the newly created reader_card' do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      library = Library.add_library('asfasas', 'asfasasafszz')
      reader_card = ReaderCard.add_reader_card(user.id, library.id)
      expect(reader_card.user.id).to eq(user.id)
      expect(reader_card.library.id).to eq(library.id)
    end

    it 'is not valid with a duplicate user and library' do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      library = Library.add_library('asfasas', 'asfasasafszz')
      ReaderCard.add_reader_card(user.id, library.id)
      reader_card = ReaderCard.add_reader_card(user.id, library.id)
      expect(reader_card).to be_nil
    end
  end

  describe '.delete_reader_card_id' do
    let!(:reader_card) do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      library = Library.add_library('asfasas', 'asfasasafszz')
      reader_card = ReaderCard.add_reader_card(user.id, library.id)
    end

    it 'deletes the reader_card with the given id' do
      ReaderCard.delete_reader_card_id(reader_card.id)
      expect(ReaderCard.find_by(id: reader_card.id)).to be_nil
    end
  end
end

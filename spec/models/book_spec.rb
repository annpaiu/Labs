require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:library) { library = Library.add_library('asfasas', 'asfasasafszz') }
  let!(:reader_card) do
    user = User.add_user('asfasf', 'afsafsfasazxz')
    reader_card = ReaderCard.add_reader_card(user.id, library.id)
  end

  describe '.add_book' do
    context 'when valid parameters are provided' do
      it 'creates a new book' do
        expect do
          Book.add_book('Test Book', '2023-04-02', library.id, reader_card.id)
        end.to change(Book, :count).by(1)
      end
    end

    context 'when invalid parameters are provided' do
      it 'returns nil' do
        book = Book.add_book('', '2023-04-02', library.id, reader_card.id)
        expect(book).to be_nil
      end
    end
  end

  describe '.update_book' do
    let!(:library) { library = Library.add_library('asfasas', 'asfasasafszz') }
    let!(:reader_card) do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      reader_card = ReaderCard.add_reader_card(user.id, library.id)
    end
    let!(:book) { book = Book.add_book('Test Book', '2023-04-02', library.id, reader_card.id) }

    context 'when valid parameters are provided' do
      it 'updates the existing book' do
        updated_book = Book.update_book('New Title', '2023-04-03', library.id, reader_card.id, book.id)
        expect(updated_book.title).to eq('New Title')
      end
    end

    context 'when invalid parameters are provided' do
      it 'returns nil' do
        updated_book = Book.update_book('', '2023-04-03', library.id, reader_card.id, book.id)
        expect(updated_book).to be_nil
      end
    end
  end

  describe '.delete_book_id' do
    let!(:library) { library = Library.add_library('asfasas', 'asfasasafszz') }
    let!(:reader_card) do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      reader_card = ReaderCard.add_reader_card(user.id, library.id)
    end
    let!(:book) { book = Book.add_book('Test Book', '2023-04-02', library.id, reader_card.id) }

    it 'deletes the book' do
      expect do
        Book.delete_book_id(book.id)
      end.to change(Book, :count).by(-1)
    end
  end

  describe '.add_book_author' do
    let!(:library) { library = Library.add_library('asfasas', 'asfasasafszz') }
    let!(:reader_card) do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      reader_card = ReaderCard.add_reader_card(user.id, library.id)
    end
    let!(:book) { book = Book.add_book('Test Book', '2023-04-02', library.id, reader_card.id) }
    let(:author) { Author.add_author('author', 123) }

    it 'adds the author to the book' do
      Book.add_book_author(book.id, author.id)
      expect(book.authors).to include(author)
    end
  end

  describe '.add_book_genre' do
    let!(:library) { library = Library.add_library('asfasas', 'asfasasafszz') }
    let!(:reader_card) do
      user = User.add_user('asfasf', 'afsafsfasazxz')
      reader_card = ReaderCard.add_reader_card(user.id, library.id)
    end
    let!(:book) { book = Book.add_book('Test Book', '2023-04-02', library.id, reader_card.id) }
    let(:genre) { Genre.add_genre('author') }

    it 'adds the genre to the book' do
      Book.add_book_genre(book.id, genre.id)
      expect(book.genres).to include(genre)
    end
  end
end

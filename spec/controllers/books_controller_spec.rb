require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:valid_attributes) do
    {
      title: 'Book Title',
      published_date: Date.today,
      library_id: Library.first.id,
      reader_card_id: ReaderCard.first.id
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      book = Book.create!(valid_attributes)
      get :show, params: { id: book.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      book = Book.create!(valid_attributes)
      get :edit, params: { id: book.to_param }
      expect(response).to be_successful
    end
  end
end

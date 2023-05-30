require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  let(:valid_attributes) do
    { name: 'Science Fiction' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Genre.create!(valid_attributes)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      genre = Genre.create!(valid_attributes)
      get :show, params: { id: genre.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Genre' do
        expect do
          post :create, params: { genre: valid_attributes }
        end.to change(Genre, :count).by(1)
      end

      it 'redirects to the created genre' do
        post :create, params: { genre: valid_attributes }
        expect(response).to redirect_to(Genre.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Genre' do
        expect do
          post :create, params: { genre: invalid_attributes }
        end.to change(Genre, :count).by(0)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      genre = Genre.create!(valid_attributes)
      get :edit, params: { id: genre.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Romance' }
      end

      it 'updates the requested genre' do
        genre = Genre.create!(valid_attributes)
        put :update, params: { id: genre.to_param, genre: new_attributes }
        genre.reload
        expect(genre.name).to eq(new_attributes[:name])
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested genre' do
      genre = Genre.create!(valid_attributes)
      expect do
        delete :destroy, params: { id: genre.to_param }
      end.to change(Genre, :count).by(-1)
    end

    it 'redirects to the genres list' do
      genre = Genre.create!(valid_attributes)
      delete :destroy, params: { id: genre.to_param }
      expect(response).to redirect_to(genres_url)
    end
  end
end

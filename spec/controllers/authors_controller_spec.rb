require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:valid_attributes) { { name: 'Test Author', birthdate: Date.today } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      author = Author.create!(valid_attributes)
      get :show, params: { id: author.to_param }
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
    context 'with valid parameters' do
      it 'creates a new Author' do
        expect do
          post :create, params: { author: valid_attributes }
        end.to change(Author, :count).by(1)
      end

      it 'redirects to the created author' do
        post :create, params: { author: valid_attributes }
        expect(response).to redirect_to(Author.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Author' do
        Author.create!(valid_attributes)
        expect do
          post :create, params: { author: valid_attributes }
        end.to_not change(Author, :count)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      author = Author.create!(valid_attributes)
      get :edit, params: { id: author.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { name: 'New Name', birthdate: Date.today - 1 } }

    context 'with valid parameters' do
      it 'updates the requested author' do
        author = Author.create!(valid_attributes)
        put :update, params: { id: author.to_param, author: new_attributes }
        author.reload
        expect(author.name).to eq(new_attributes[:name])
        expect(author.birthdate).to eq(new_attributes[:birthdate])
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested author' do
      author = Author.create!(valid_attributes)
      expect do
        delete :destroy, params: { id: author.to_param }
      end.to change(Author, :count).by(-1)
    end

    it 'redirects to the authors list' do
      author = Author.create!(name: 'John Doe', birthdate: '2000-01-01')
      delete :destroy, params: { id: author.id }
      expect(response).to redirect_to(authors_path)
    end
  end
end

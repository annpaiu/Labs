require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
  let(:valid_attributes) { { name: 'New Library', location: 'New Location' } }
  let(:invalid_attributes) { { name: nil, location: nil } }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      library = Library.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      library = Library.create! valid_attributes
      get :show, params: { id: library.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Library' do
        expect do
          post :create, params: { library: valid_attributes }, session: valid_session
        end.to change(Library, :count).by(1)
      end

      it 'redirects to the created library' do
        post :create, params: { library: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Library.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { library: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      library = Library.create! valid_attributes
      get :edit, params: { id: library.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Library', location: 'Updated Location' } }

      it 'updates the requested library' do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: new_attributes }, session: valid_session
        library.reload
        expect(library.name).to eq('Updated Library')
        expect(library.location).to eq('Updated Location')
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end

    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Updated Library Name', location: 'Updated Library Location' }
      end

      it 'updates the requested library' do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: new_attributes }, session: valid_session
        library.reload
        expect(library.name).to eq('Updated Library Name')
        expect(library.location).to eq('Updated Library Location')
      end

      it 'redirects to the library' do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: new_attributes }, session: valid_session
        expect(response).to redirect_to(library)
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested library' do
        library = Library.create! valid_attributes
        expect do
          delete :destroy, params: { id: library.to_param }, session: valid_session
        end.to change(Library, :count).by(-1)
      end

      it 'redirects to the libraries list' do
        library = Library.create! valid_attributes
        delete :destroy, params: { id: library.to_param }, session: valid_session
        expect(response).to redirect_to(libraries_url)
      end
    end
  end
end

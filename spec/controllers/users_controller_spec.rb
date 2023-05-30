require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) { { name: 'John', email: 'john@example.com' } }
  let(:invalid_attributes) { { name: '', email: 'john@example.com' } }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      user = User.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      user = User.create! valid_attributes
      get :show, params: { id: user.to_param }, session: valid_session
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
      it 'creates a new User' do
        expect do
          post :create, params: { user: valid_attributes }, session: valid_session
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }, session: valid_session
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new User' do
        expect do
          post :create, params: { user: invalid_attributes }, session: valid_session
        end.to change(User, :count).by(0)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      user = User.create! valid_attributes
      get :edit, params: { id: user.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'John Smith', email: 'john_smith@example.com' }
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        patch :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
        user.reload
        expect(user.name).to eq(new_attributes[:name])
        expect(user.email).to eq(new_attributes[:email])
      end
    end

    context 'with invalid params' do
      it 'does not update the user' do
        user = User.create! valid_attributes
        patch :update, params: { id: user.to_param, user: invalid_attributes },
                       session: valid_session
        user.reload
        expect(user.name).to eq(valid_attributes[:name])
        expect(user.email).to eq(valid_attributes[:email])
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect do
        delete :destroy, params: { id: user.to_param }, session: valid_session
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete :destroy, params: { id: user.to_param }, session: valid_session
      expect(response).to redirect_to(users_url)
    end
  end
end

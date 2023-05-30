require 'rails_helper'

RSpec.describe ReaderCardsController, type: :controller do
  let(:valid_attributes) do
    { user_id: User.first.id, library_id: Library.last.id }
  end

  let(:invalid_attributes) do
    { user_id: nil, library_id: nil }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      ReaderCard.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      reader_card = ReaderCard.create! valid_attributes
      get :show, params: { id: reader_card.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      reader_card = ReaderCard.create! valid_attributes
      get :edit, params: { id: reader_card.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ReaderCard' do
        expect do
          post :create, params: { reader_card: valid_attributes }, session: valid_session
        end.to change(ReaderCard, :count).by(1)
      end

      it 'redirects to the created reader_card' do
        post :create, params: { reader_card: valid_attributes }, session: valid_session
        expect(response).to redirect_to(ReaderCard.last)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) do
      { user_id: User.last.id, library_id: Library.first.id }
    end

    context 'with valid params' do
      it 'updates the requested reader_card' do
        reader_card = ReaderCard.create! valid_attributes
        put :update, params: { id: reader_card.to_param, reader_card: new_attributes }, session: valid_session
        reader_card.reload
        expect(reader_card.user_id).to eq(new_attributes[:user_id])
        expect(reader_card.library_id).to eq(new_attributes[:library_id])
      end

      it 'redirects to the reader_card' do
        reader_card = ReaderCard.create! valid_attributes
        put :update, params: { id: reader_card.to_param, reader_card: new_attributes }, session: valid_session
        expect(response).to redirect_to(reader_card)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested reader_card' do
      reader_card = ReaderCard.create! valid_attributes
      expect do
        delete :destroy, params: { id: reader_card.to_param }, session: valid_session
      end.to change(ReaderCard, :count).by(-1)
    end
    it 'redirects to the reader_cards list' do
      reader_card = ReaderCard.create! valid_attributes
      delete :destroy, params: { id: reader_card.to_param }, session: valid_session
      expect(response).to redirect_to(reader_cards_url)
    end
  end
end

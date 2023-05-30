require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'John Doe', email: 'johndoe@example.com')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(name: 'John Doe')
      expect(user).not_to be_valid
    end

    it 'is not valid without an email and name' do
      user = User.new
      expect(user).not_to be_valid
    end

    it 'is not valid without an name' do
      user = User.new(email: 'johndoe@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(name: 'Jane Doe', email: 'johndoe@example.com')
      user = User.new(name: 'John Doe', email: 'johndoe@example.com')
      expect(user).not_to be_valid
    end
  end

  describe '.add_user' do
    it 'creates a new user' do
      expect { User.add_user('Jane Doe', 'janedoe@example.com') }.to change { User.count }.by(1)
    end

    it 'returns the newly created user' do
      user = User.add_user('Jane Doe', 'janedoe@example.com')
      expect(user.name).to eq('Jane Doe')
      expect(user.email).to eq('janedoe@example.com')
    end

    it 'returns nil when user is not valid name' do
      user = User.add_user(nil, 'janedoe@example.com')
      expect(user).to be_nil
    end

    it 'returns nil when user is not valid email' do
      user = User.add_user('Jane Doe', nil)
      expect(user).to be_nil
    end

    it 'returns nil when user is not valid name, email' do
      user = User.add_user(nil, nil)
      expect(user).to be_nil
    end
  end

  describe '.update_user' do
    let!(:user) { User.create(name: 'John Doe', email: 'johndoe@example.com') }

    it 'updates the user with the given attributes' do
      updated_user = User.update_user('Jane Doe', 'janedoe@example.com', user.id)
      expect(updated_user.name).to eq('Jane Doe')
      expect(updated_user.email).to eq('janedoe@example.com')
    end

    it 'returns nil when user is not valid name' do
      updated_user = User.update_user(nil, 'janedoe@example.com', user.id)
      expect(updated_user).to be_nil
    end

    it 'returns nil when user is not valid email' do
      updated_user = User.update_user('Jane Doe', nil, user.id)
      expect(updated_user).to be_nil
    end

    it 'returns nil when user is not valid name email' do
      updated_user = User.update_user(nil, nil, user.id)
      expect(updated_user).to be_nil
    end

    it 'returns nil when user is not valid email uniqueness' do
      updated_user = User.update_user('Jane Doe', 'johndoe@example.com', user.id)
      expect(updated_user).to be_nil
    end
  end

  describe '.delete_user_id' do
    let!(:user) { User.create(name: 'John Doe', email: 'johndoe@example.com') }

    it 'deletes the user with the given id' do
      User.delete_user_id(user.id)
      expect(User.find_by(id: user.id)).to be_nil
    end
  end
end

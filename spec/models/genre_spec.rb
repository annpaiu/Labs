require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'validations' do
    it 'requires a name' do
      genre = Genre.new
      genre.valid?
      expect(genre.errors[:name]).to include("can't be blank")
    end

    it 'requires a unique name' do
      Genre.create(name: 'Fantasy')
      genre = Genre.new(name: 'Fantasy')
      genre.valid?
      expect(genre.errors[:name]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'has many book genres' do
      genre = Genre.reflect_on_association(:book_genres)
      expect(genre.macro).to eq(:has_many)
    end

    it 'has many books through book genres' do
      genre = Genre.reflect_on_association(:books)
      expect(genre.macro).to eq(:has_many)
      expect(genre.options[:through]).to eq(:book_genres)
    end
  end

  describe '.add_genre' do
    it 'creates a new genre with valid attributes' do
      expect do
        Genre.add_genre('New Genre')
      end.to change(Genre, :count).by(1)
    end

    it 'does not create a new genre with invalid attributes' do
      expect do
        Genre.add_genre(nil)
      end.not_to change(Genre, :count)
    end
  end

  describe '.update_genre' do
    let!(:genre) { Genre.create(name: 'Old Genre') }

    it 'updates an existing genre with valid attributes' do
      Genre.update_genre('New Genre', genre.id)
      expect(genre.reload.name).to eq('New Genre')
    end

    it 'does not update an existing genre with invalid attributes' do
      Genre.update_genre(nil, genre.id)
      expect(genre.reload.name).to eq('Old Genre')
    end
  end

  describe '.delete_genre_id' do
    let!(:genre) { Genre.create(name: 'Old Genre') }

    it 'deletes the specified genre' do
      expect do
        Genre.delete_genre_id(genre.id)
      end.to change(Genre, :count).by(-1)
    end
  end
end

require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      library = Library.new(name: 'Main Library', location: 'New York')
      expect(library).to be_valid
    end

    it 'is not valid without a name' do
      library = Library.new(location: 'New York')
      expect(library).not_to be_valid
    end

    it 'is not valid without a location' do
      library = Library.new(name: 'Main Library')
      expect(library).not_to be_valid
    end

    it 'is not valid with a duplicate name and location combination' do
      Library.create(name: 'Main Library', location: 'New York')
      library = Library.new(name: 'Main Library', location: 'New York')
      expect(library).not_to be_valid
    end
  end

  describe '.add_library' do
    it 'creates a new library' do
      expect do
        Library.add_library('Main Library', 'New York')
      end.to change(Library, :count).by(1)
    end
  end

  describe '.update_library' do
    let!(:library) { Library.create(name: 'Main Library', location: 'New York') }

    it 'updates an existing library' do
      expect do
        Library.update_library('Central Library', 'Los Angeles', library.id)
      end.to change { library.reload.name }.from('Main Library').to('Central Library').and(
        change { library.reload.location }.from('New York').to('Los Angeles')
      )
    end
  end

  describe '.delete_library_id' do
    let!(:library) { Library.create(name: 'Main Library', location: 'New York') }

    it 'deletes a library' do
      expect do
        Library.delete_library_id(library.id)
      end.to change(Library, :count).by(-1)
    end
  end
end

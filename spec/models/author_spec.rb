require 'rails_helper'

RSpec.describe Author, type: :model do
  describe '#add_author' do
    context 'when valid parameters are provided' do
      it 'should create a new author' do
        expect do
          Author.add_author('John Smith', '1990-01-01')
        end.to change { Author.count }.by(1)
      end
    end

    context 'when invalid parameters are provided' do
      it 'should not create a new author and return nil' do
        expect do
          Author.add_author(nil, '1990-01-01')
        end.to_not change { Author.count }

        expect(Author.add_author(nil, '1990-01-01')).to be_nil
      end
    end
  end

  describe '#update_author' do
    let!(:author) { Author.create(name: 'John Smith', birthdate: '1990-01-01') }

    context 'when valid parameters are provided' do
      it 'should update an existing author' do
        updated_author = Author.update_author('New Name', '2000-01-01', author.id)
        expect(updated_author).to be_a(Author)
        expect(updated_author.name).to eq('New Name')
      end
    end

    context 'when invalid parameters are provided' do
      it 'should not update an existing author and return nil' do
        expect(Author.update_author(nil, '2000-01-01', author.id)).to be_nil
        expect(Author.update_author('New Name', nil, author.id)).to be_nil
        expect(Author.update_author('John Smith', '1990-01-01', nil)).to be_nil
      end
    end
  end

  describe '#delete_author_id' do
    let!(:author) { Author.create(name: 'John Smith', birthdate: '1990-01-01') }

    it 'should delete an existing author' do
      expect do
        Author.delete_author_id(author.id)
      end.to change { Author.count }.by(-1)
    end
  end
end

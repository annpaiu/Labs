ActiveAdmin.register Book do

  permit_params :title, :published_date, :library_id , :reader_card_id

  filter :title
  filter :published_date
  filter :reader_card
  filter :library

  show do
    attributes_table do
      row :title
      row :published_date
      row :reader_card
      row :library
    end
  end

  index do
    selectable_column
    column :id
    column :title
    column :published_date
    column :reader_card
    column :library
    actions
  end

  form do |f|
    f.inputs 'Book' do
      f.input :title
      f.input :published_date
      f.input :reader_card
      f.input :library
    end
    f.actions
  end

end
